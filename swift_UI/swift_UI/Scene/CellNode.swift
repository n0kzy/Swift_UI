//
//  CellNode.swift
//  swift_UI
//
//  Created by etudiant on 03/06/2025.
//

import SpriteKit


public class CellNode: SKNode {

    let width : CGFloat
    let height : CGFloat

    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        super.init()
        let shapeNode = SKShapeNode(ellipseOf: CGSize(width: width, height: height))
        shapeNode.fillColor = .white
        shapeNode.strokeColor = .black
        shapeNode.lineWidth = 5
        self.addChild(shapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //obligatoire a override pour faire du drag & drop
    override public var isUserInteractionEnabled: Bool {
        get  { true }
        set { }
    }
    
    var ghost : CellNode?
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let dragged = CellNode(width: self.width, height: self.height)
        ghost = dragged
        //on ajoute le dragged comme enfant de la scène
        self.parent?.parent!.addChild(dragged)
        
        //TouchesUtil(dragged: dragged, touches: touches)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let dragged = ghost else { return }
        //let cord = getLocFromTouches(from: touches.first, in: self)
        
        //dragged.position = cord

        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let dropped = ghost, let touch = touches.first else { return }

        guard let scene = self.scene,
              let boardNode = scene.children.first(where: { $0 is BoardNode }) as? BoardNode else { return }

        //let locationInBoard = touch.location(in: boardNode)

//        let cellWidth = boardNode.width / CGFloat(boardNode.nbColumns)
        //let cellHeight = boardNode.height / CGFloat(boardNode.nbRows)
        
        let (row, col) = getCellCord(from: touch, in: boardNode)

        //let col = Int((locationInBoard.x + boardNode.width / 2) / cellWidth)
        if col >= 0 && col < boardNode.nbColumns {
            let destCell = boardNode.cellMatric[row][col]
            let moveAction = SKAction.move(to:destCell.position,duration:0.1)
            dropped.run(moveAction) {
                boardNode.cellMatric[row][col] = dropped
                dropped.removeFromParent()
            }
        }
        dropped.removeFromParent()
        ghost = nil
    }
    
    
    
}


