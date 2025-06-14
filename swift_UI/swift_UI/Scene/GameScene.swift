//
//  GameScene.swift
//  swift_UI
//
//  Created by etudiant on 25/05/2025.
//

import SpriteKit
import SwiftUICore
import Connect4Core
import Connect4Rules
public class GameScene: SKScene {
    
    //la gameScene connait la GameViewMode
    //let game : GameViewModel?
    let nbRows: Int
    let nbColumns: Int
    
     public init(size:CGSize,nbRows:Int,nbColumns:Int) {
        self.nbRows = nbRows
        self.nbColumns = nbColumns
        super.init(size: size)
        self.scaleMode = .aspectFit
        self.backgroundColor = .blue
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
         let boardNode = BoardNode(width: size.width , height: size.height, nbColumns:nbColumns, nbRows: nbRows)

        boardNode.position = CGPoint.zero
        self.addChild(boardNode)
        initTopBar()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTopBar() {
        let topBar = SKNode()
        self.addChild(topBar)
        let p1 = PlayerNode(width: 80, height: 80,color: .yellow)
        let p2 = PlayerNode(width: 80, height: 80,color: .red)
        topBar.addChild(p1)
        topBar.addChild(p2)
        
        p1.position.x = self.size.width / 3 - 400
        p1.position.y = self.size.height / 2 
        p2.position.x = self.size.width  / 3
        p2.position.y = self.size.height / 2
        

        
         
    }
    
    
}
