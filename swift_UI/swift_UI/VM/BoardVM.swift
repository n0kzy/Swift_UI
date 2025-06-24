//
//  BoardVM.swift
//  swift_UI
//
//  Created by etudiant on 26/05/2025.
//

import SwiftUI
import Connect4Core

public class BoardVM: ObservableObject {
    @Published var board : Board
    
    init(board: Board) {
        self.board = board
    }
    
    
    /*
    func playMove(col:Int) -> Int {
        let res = board.insert(piece: Piece(withOwner: .player1), atColumn: col)
        return res
    }
     */

}
