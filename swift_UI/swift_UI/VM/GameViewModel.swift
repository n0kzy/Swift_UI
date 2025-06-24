//
//  GameViewModel.swift
//  swift_UI
//
//  Created by etudiant on 21/05/2025.
//

import Foundation
import Foundation
import Connect4Core
import Connect4Rules
import Connect4Players
import Connect4Persistance

extension Game {
    struct Data: Equatable, Codable {
        public var name: String
        public var score: Int
        public var type: String
    }

    var editableData: Data {
        return Data(
            name: "\(self.players[.player1]?.name ?? "player1") vs \( self.players[.player2]?.name ?? "player2")",
            score:0,
            type:self.rules.name.components(separatedBy: " ").first!)
    }
}

public class GameViewModel: ObservableObject, Identifiable {
    public let id: UUID
    @Published var isEditing = false
    @Published var game: Game
    @Published var editableData: Game.Data
    @Published var p1 : PlayerVM
    @Published var p2 : PlayerVM
    var currPlayer : Owner
    var currMove : Move

    init(game: Game, data: Game.Data? = nil,p1:PlayerVM = PlayerVM(player: HumanPlayer(withName: "P1", andId: Owner.player1)!) ,p2:PlayerVM = PlayerVM(player: HumanPlayer(withName: "P2", andId: Owner.player2)!)) {
        self.p1 = p1
        self.p2 = p2
        self.game = game
        let defaultData = game.editableData
        self.editableData = data ?? defaultData
        self.id = UUID()
        self.currPlayer = .player1
        self.currMove = Move(of: .player1, toRow: 0, toColumn: 0)
        
    }
    
    init() {
        let player1 = PlayerVM(player: HumanPlayer(withName: "P2", andId: Owner.player1)!)
        let player2 = PlayerVM(player: HumanPlayer(withName: "P2", andId: Owner.player2)!)
        let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
        try! Connect4Core.Game(withRules: rules, andPlayer1: player1.player, andPlayer2: player2.player)
        let g = try! Game(withRules: rules, andPlayer1: player1.player, andPlayer2: player2.player)
        self.game = g
        self.editableData = g.editableData
        self.id = UUID()
        self.p1 = player1
        self.p2 = player2
        self.currPlayer = .player1
        self.currMove = Move(of: .player1, toRow: 0, toColumn: 0)

    }
    
    
    var getCurrMove : Move {
        currMove
    }
    
    var getCurrPlayer : Owner {
        currPlayer
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

    func startEditing() async throws {
        isEditing = true
        editableData = game.editableData
        try await game.start()
    }
    
    func stopEditing() async throws {
        isEditing = false
    }
    
    static func choosePlayerTypeAndName(_ player: Owner, type: String,name:String) -> Player? {
        switch type.lowercased() {
        case "random":
            return RandomPlayer(withName: "Random", andId: player)
        case "finnish him":
            return FinnishHimPlayer(withName: "Finnish Him", andId: player)
        case "simple negamax":
            return SimpleNegaMaxPlayer(withName: "SimpleNegaMax", andId: player)
        default:
            return HumanPlayer(withName: name, andId: player)
        }
    }

    
    @MainActor
    public func initListener(withScene scene: GameScene) {
        game.addGameStartedListener {
            print($0)
            print("*************    *************************")
            print("     ==>> 🎉 GAME STARTS! 🎉 <<==     ")
            print("**************************************")
            /*
            if self.p1.type != "Human" && self.p2.type != "Human" {
                let move = Move(of: .player1, toRow: 0, toColumn: 3)
                Task {
                    await scene.addPiece(cell: move)
                }
            }*/
        }
        
          self.game.addInvalidMoveCallbacksListener { _, move, player, result in
            if result {
                return
            }
            print("Invalid Move Detected")
        }
        
        game.addGameChangedListener { game, result in
            
            await PersistanceVM.shared.saveGame(game: game)

            if result != .notFinished {
            await  PersistanceVM.shared.saveResult(for: game, result: result)

            }
        }
         
        game.addGameOverListener { board, result, _ in
            switch(result){
            case .notFinished:
                print("⏳ Game is not over yet!")
                return
            case .winner(winner: let o, alignment: let r):
                let player = o == .player1 ? "🟡 Joueur 1" : "🔴 Joueur 2"
                scene.displayEndMessage("🎉 Victoire de \(player) 🎉")

            case .even:
                print("Game finished with no winner! Congratulations to both of you!")
                
            }
            Task {
                try await self.stopEditing()
                await  PersistanceVM.shared.deleteGame()
            }
        }
        
        game.addBoardChangedListener { [weak self] board, cell in
            guard let self = self  else { return }
            // Vérifie si c'est une cellule avec une pièce
            guard let cell = cell, let piece = cell.piece else {
                print("Cellule vide ou sans pièce")
                return
            }
            let playerId = piece.owner

            let iaTypes = ["random", "finnish him", "simple negamax"]
            let playerType = (playerId == p1.player.id ? p1.type : p2.type).lowercased()

            guard iaTypes.contains(playerType) else {
                print("Type IA inconnu ou non-IA (\(playerType))")
                return
            }
            guard let owner = cell.piece?.owner else { return }

            let move = Move(of: owner, toRow: cell.row, toColumn: cell.col)
            do {
                let isValid = try game.rules.isMoveValid(onBoard: board, withMove: move)
                if isValid {
                    print("Coup valide !")
                } else {
                    print("Coup invalide.")
                }
            } catch {
                print("Erreur lors de la vérification : \(error)")
            }
            if isEditing {
                Task {
                    try await Task.sleep(nanoseconds: 500_000_000)
                    await scene.addPiece(cell: move)
                }
            }

        }

        
        game.addMoveChosenCallbacksListener { board, move, player in

        }

          
          self.game.addPlayerNotifiedListener { _, player  in
                  self.currPlayer = player.id
              print("Player \(player.id == .player1 ? "🟡" : "🔴")")
              Task {
                  try! await Task.sleep(nanoseconds: 1000000)
              }
          }

    }


    public func playMove(column: Int) async -> Int {
        do {
            guard let row = game.board.getFirstEmptyRow(of: column) else {
                print("Colonne pleine")
                return -1
            }
            let move = Move(of: currPlayer, toRow: row, toColumn: column)
            try await game.onPlayed(move: move)
            return row
        } catch {
            print("Erreur pendant le coup : \(error)")
        }
        return -1
    }
}
