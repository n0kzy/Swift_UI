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
    
    var gameViewModel : GameViewModel
    var p1: PlayerNode!
    var p2: PlayerNode!
    var boardNode : BoardNode
    var isGameOver = false
    
     public init(size:CGSize,gameViewModel: GameViewModel) {
         self.gameViewModel = gameViewModel
         let boardNode = BoardNode(width: size.width , height: size.height - 150, g:gameViewModel)
        boardNode.position = CGPoint(x: 0, y: -150 / 2)
         self.boardNode = boardNode
        super.init(size: size)
        self.scaleMode = .aspectFit
        self.backgroundColor = .blue
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        self.addChild(boardNode)
        initTopBar()
         gameViewModel.initListener(withScene: self)
         Task {
             try await gameViewModel.startEditing()
         }

    }
    
    public func reloadGame() {
        isGameOver = false
        self.removeAllChildren()
        self.addChild(boardNode)
        initTopBar()
        boardNode.removeAllChildren()
        boardNode.resetCells()
        gameViewModel.resetGame()
        boardNode.initCells()
    }
    
    public func onPlay(row:Int,col:Int) async -> Int {
        
        guard !isGameOver else {
            print("jeu terminé")
            return -1
        }
        
        let m = await gameViewModel.playMove(column:col)
        p1.isHidden = self.gameViewModel.getCurrPlayer != .player1
        p2.isHidden = self.gameViewModel.getCurrPlayer != .player2
        return m
    }

    func displayEndMessage(_ message: String) {
        isGameOver = true
        let label = SKLabelNode(text: message)
        label.name = "messageLabel"
        label.fontSize = 60
        label.fontColor = .white
        label.fontName = "Helvetica-Bold"
        label.position = CGPoint(x: 0, y: 250)
        label.zPosition = 1
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        self.addChild(label)
        p1.removeFromParent()
        p2.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPiece(cell: Move) async {

        let cellWidth = boardNode.width / CGFloat(gameViewModel.game.board.nbColumns)
        let cellHeight = boardNode.height / CGFloat(gameViewModel.game.board.nbRows)


        let color: UIColor = cell.owner == .player1 ? .yellow : .red

        let piece = PlayerNode(
            width: cellWidth * 0.8,
            height: cellHeight * 0.8,
            color: color
        )

        let x = CGFloat(cell.column) * cellWidth + cellWidth / 2 - boardNode.width / 2
        let y = CGFloat(cell.row) * cellHeight + cellHeight / 2 - boardNode.height / 2

        piece.position = CGPoint(x: x, y: 300)
        boardNode.addChild(piece)
        
        let fall = SKAction.move(to: CGPoint(x: x, y: y), duration: 0.3)
        fall.timingMode = .easeOut
        let shakeLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.03)
        let shakeRight = SKAction.moveBy(x: 10, y: 0, duration: 0.03)
        let shakeBack = SKAction.moveBy(x: -5, y: 0, duration: 0.03)
        let shake = SKAction.sequence([shakeLeft, shakeRight, shakeBack])
        let repeatShake = SKAction.repeat(shake, count: 3)
        let fullSequence = SKAction.sequence([fall, repeatShake])
        piece.isDraggable = false
        await piece.run(fullSequence)

    }

    func addPiece(_ piece: PlayerNode, atColumn col: Int,atRow row:Int,color:UIColor) async {
        let cellWidth = boardNode.width / CGFloat(gameViewModel.game.board.nbColumns)
        let cellHeight = boardNode.height / CGFloat(gameViewModel.game.board.nbRows)
        //await game?.playMove(column: col)
        if let gameScene = self.scene as? GameScene {
            let r: Int = await gameScene.onPlay(row: row, col: col)
            var x , y : CGFloat
            if (gameViewModel.game.rules is TicTacToeRules) {
                
                x = CGFloat(col) * cellWidth + cellWidth / 2 - boardNode.width / 2
                y = CGFloat(row) * cellHeight + cellHeight / 2 - boardNode.height / 2
            } else {
                if r < 0 {
                    print("colonne pleine")
                }
                x = CGFloat(col) * cellWidth + cellWidth / 2 - boardNode.width / 2
                y = CGFloat(r) * cellHeight + cellHeight / 2 - boardNode.height / 2
                
                
                piece.position = CGPoint(x: x, y: 300)
                boardNode.addChild(piece)
                
                let fall = SKAction.move(to: CGPoint(x: x, y: y), duration: 0.35)
                fall.timingMode = .easeIn
                let bounce = SKAction.moveBy(x: 0, y: 30, duration: 0.1)
                bounce.timingMode = .easeOut

                let settle = SKAction.moveBy(x: 0, y: -30, duration: 0.1)
                settle.timingMode = .easeIn

                let sequence = SKAction.sequence([fall, bounce, settle])
                piece.isDraggable = false
                await piece.run(sequence)
            }
        }
    }
    
    func initTopBar() {
        let topBar = SKNode()
        topBar.name = "topBar"
        topBar.position = CGPoint(x: 0, y: size.height / 2 - ( 150 / 2))
        self.addChild(topBar)
        
        let bg = SKShapeNode(rectOf: CGSize(width: size.width, height: 150))
        bg.fillColor = .clear

        topBar.addChild(bg)
        let cellWidth = boardNode.width / CGFloat(gameViewModel.game.board.nbColumns)
        let cellHeight = boardNode.height / CGFloat(gameViewModel.game.board.nbRows)
        p1 = PlayerNode(width: cellWidth * 0.8, height: cellHeight * 0.8,color: .yellow)
        p2 = PlayerNode(width: cellWidth * 0.8, height: cellHeight * 0.8,color: .red)

        
        p1.position = CGPoint(x: -size.width / 3, y: 0)
        p2.position = CGPoint(x: size.width / 3, y: 0)
        
        p1.zPosition = 1
        p2.zPosition = 1
        p2.isHidden = true
        topBar.addChild(p1)
        topBar.addChild(p2)
    }
    
    
}
