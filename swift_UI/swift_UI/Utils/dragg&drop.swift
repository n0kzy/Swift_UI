//
//  dragg&drop.swift
//  swift_UI
//
//  Created by etudiant on 11/06/2025.
//

import UIKit
import SpriteKit

public func TouchesUtil(dragged:PlayerNode, touches:Set<UITouch>) {
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in:dragged.parent! )
    dragged.position = CGPoint(x: touchPoint.x - dragged.width / 2 + 20 , y: touchPoint.y - dragged.height / 2 + 20)
}

public func getCellCord(from touch: UITouch, in board: BoardNode) -> (row:Int,col:Int) {
    let touchPoint = touch.location(in:board)
    let col = Int(( (touchPoint.x + board.width / 2) / (board.width / CGFloat(board.nbColumns)) ))
    let row = Int(( (touchPoint.y + board.height / 2) / (board.height / CGFloat(board.nbRows))))

    return(row,col)
}
