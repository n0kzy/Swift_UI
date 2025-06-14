//
//  GamesVM.swift
//  swift_UI
//
//  Created by etudiant on 28/05/2025.
//

import SwiftUI
import Connect4Core
import Connect4Persistance

class GamesVM: ObservableObject {
    let id = UUID()
    @Published var games : [GameViewModel]

    init(with games: [Game]) {
        self.games = games.map { GameViewModel(game: $0) }
    }

    
    func save() async {

        do {
            for game in games {
                var g = try await Persistance.saveGame(withName:"games.json", andGame: game.game,withFolderName: "game")
                //try await Persistance.addPlayer(withName: "players.json", andPlayer: game.game.players, withFolderName: "player")
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func load() async {
            do {
                var game = try await Persistance.loadGame(withName:"games.json")
                games.append(GameViewModel(game: game!))
                var t = try await Persistance.getPlayers(withName: "games.json", withFolderName: "game")

            } catch {
                print(error.localizedDescription)
            }
    }
                          
    func update(with gameVM: GameViewModel) {
        if let i = games.firstIndex(where: { $0.id == gameVM.game.editableData.id }) {
            games[i] = gameVM
        } else {
            games.append(gameVM)
        }
    }
    

}

