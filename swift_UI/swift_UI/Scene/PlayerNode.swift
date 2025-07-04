//
//  PlayerNode.swift
//  swift_UI
//
//  Created by etudiant on 03/06/2025.
//
import SpriteKit
import SwiftUICore
public class PlayerNode : SKNode {
    let width : CGFloat
    let height : CGFloat
    let color : UIColor
    
    public init(width: CGFloat,height:CGFloat,color:UIColor) {
        self.width = width
        self.height = height
        self.color = color
        super.init()
        let sprite = SKSpriteNode()
        sprite.color = color
        sprite.size = CGSize(width: width, height: height)
        sprite.position = CGPoint(x: 0, y: 0)
        
        let mask = SKShapeNode(ellipseOf: CGSize(width: width, height: height))
        mask.fillColor = .white
        mask.strokeColor = .clear
        mask.position = .zero

        let crop = SKCropNode()
        crop.maskNode = mask
        crop.addChild(sprite)

        self.addChild(crop)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var ghost : PlayerNode?
    var isDraggable: Bool = true
    //obligatoire a override pour faire du drag & drop
    override public var isUserInteractionEnabled: Bool {
        get  { true }
        set { }
    }
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDraggable else { return }
        let dragged = PlayerNode(width: self.width, height: self.height,color: self.color)
        ghost = dragged
        //on ajoute le dragged comme enfant de la scène
        self.parent?.parent!.addChild(dragged)
        
        TouchesUtil(dragged: dragged, touches: touches)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let dragged = ghost else { return }
        TouchesUtil(dragged: dragged, touches: touches)

        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let dropped = ghost, let touch = touches.first else { return }
        guard let scene = self.scene as? GameScene,
              let boardNode = scene.children.first(where: { $0 is BoardNode }) as? BoardNode else { return }

        guard !scene.isGameOver else { return }
        let (row, col) = getCellCord(from: touch, in: boardNode)

        dropped.removeFromParent()
        if col >= 0 && col < boardNode.nbColumns {
                Task {
                    await scene.addPiece(dropped, atColumn: col,atRow: row,color:self.color)
                }
            }

        ghost = nil
    }
    

     
}
