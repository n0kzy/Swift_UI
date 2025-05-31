//
//  GameViewModel.swift
//  swift_UI
//
//  Created by etudiant on 21/05/2025.
//

import Foundation
import Connect4Core
import Combine

extension Game {
    struct Data: Equatable, Identifiable, Codable {
        public let id: UUID
        public var name: String
        public var score: Int
        public var type: String
    }

    var editableData: Data {
        return Data(
            id: UUID(),
            name: "\(self.players[.player1]?.name ?? "player1") vs \( self.players[.player2]?.name ?? "player2")",
            score:0,
            type:self.rules.name.components(separatedBy: " ").first!)
    }
}

class GameViewModel: ObservableObject, Identifiable {
    let id: UUID
    @Published var isEditing = false
    @Published var game: Game
    @Published var editableData: Game.Data
    init(game: Game, data: Game.Data? = nil) {
        self.game = game
        let defaultData = game.editableData
        self.editableData = data ?? defaultData
        self.id = game.editableData.id
    }

    var name: String {
        editableData.name
    }

    var score: Int {
        editableData.score
    }

    var type: String {
        editableData.type
    }

    func startEditing() {
        isEditing = true
        editableData = game.editableData
    }



    func playMove(column: Int) async {
        do {
            guard let row = game.board.getFirstEmptyRow(of: column) else {
                print("Colonne pleine")
                return
            }
            let move = Move(of: .player1, toRow: row, toColumn: column)
            try await game.onPlayed(move: move)
            objectWillChange.send()
        } catch {
            print("Erreur pendant le coup : \(error)")
        }
    }
}
