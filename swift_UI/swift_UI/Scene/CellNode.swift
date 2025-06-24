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
    

    
    
    
}


