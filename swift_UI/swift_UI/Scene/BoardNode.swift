//
//  BoardNode.swift
//  swift_UI
//
//  Created by etudiant on 03/06/2025.
//

import SpriteKit
import Connect4Core
public class BoardNode: SKNode {
    let width : CGFloat
    let height : CGFloat
    let nbColumns : Int
    let nbRows : Int
    var g : GameViewModel
    
    public init(width: CGFloat, height: CGFloat,g:GameViewModel) {
        self.width = width
        self.height = height
        self.g = g
        self.nbColumns = g.game.board.nbColumns
        self.nbRows = g.game.board.nbRows
        super.init()
        let rect = SKShapeNode(rect: CGRect(x: -width / 2, y: -height / 2, width: width, height: height))
        rect.fillColor = .blue
        rect.zPosition = -1
        self.addChild(rect)
        initCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var cellMatric : [[CellNode]] = []
    func initCells() {
        let cellsNode = SKNode()
        let cellWidth = self.width / CGFloat(nbColumns)
        let cellHeight = self.height / CGFloat(nbRows)
        
        for row in 0..<nbRows {
            cellMatric.append([])
            for col in 0..<nbColumns {
                let cell = CellNode(width: cellWidth * 0.8, height: cellHeight * 0.8)
                //let x = CGFloat(col) * cellWidth
                //let y = CGFloat(row) * cellHeight
                let x = CGFloat(col) * cellWidth - width / 2 + cellWidth / 2
                let y = CGFloat(row) * cellHeight - height / 2 + cellHeight / 2
                cellMatric[row].append(cell)
                cell.position = CGPoint(x: x, y: y)
                cellsNode.addChild(cell)
            }
        }
        self.addChild(cellsNode)
    }
    
    func resetCells() {
        cellMatric = []
    }

/*
    func addPiece(_ piece: SKNode, atColumn col: Int,atRow row:Int,color:UIColor) async {
        let cellWidth = width / CGFloat(nbColumns)
        let cellHeight = height / CGFloat(nbRows)
        //await game?.playMove(column: col)
        if let gameScene = self.scene as? GameScene {
            await gameScene.onPlay(row: row, col: col)
            let data = g.currMove
            let x = CGFloat(data.col) * cellWidth + cellWidth / 2 - width / 2
            let y = CGFloat(data.row) * cellHeight + cellHeight / 2 - height / 2
            piece.position = CGPoint(x: x, y: y)
        }
        self.addChild(piece)
    }
 */

    
}
