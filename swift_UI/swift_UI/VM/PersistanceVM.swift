//
//  PersistanceVM.swift
//  swift_UI
//
//  Created by etudiant on 12/06/2025.
//

import SwiftUI
import Connect4Core
import Connect4Persistance


public class PersistanceVM : ObservableObject {
    
    @Published var games : [GameViewModel]
    @Published var players : [PlayerVM]
    
    init(games: [Game],players:[Player] ) {
        self.games = games.map { GameViewModel(game: $0) }
        self.players = players.map { PlayerVM(player:$0, image: Image("connect"))}
    }
    
    func saveGame()  {
        Task {
            var success = true
            
            for game in games {
                do {
                    let result = try await Persistance.saveGame(withName: "games.json", andGame: game.game, withFolderName: "game")
                    if result == false {
                        success = false
                    }
                } catch {
                    print("Erreur lors de la sauvegarde du jeu : \(error)")
                    success = false
                }
            }
            
            /*
             for p in players {
             do {
             try await Persistance.addPlayer(withName: "players.json", andPlayer: p, withFolderName: "player")
             } catch {
             print("Erreur lors de l'ajout du joueur : \(error)")
             success = false
             }
             }
             */
            
            // Appelle la fermeture avec le résultat final
        }
    }
    
    func savePlayers() {
        Task {
            for p in players {
                do {
                    try await Persistance.addPlayer(withName: "players.json", andPlayer: p.player, withFolderName: "player")
                }
            }
        }
    }
    func load()  {
        Task {
            let game = try await Persistance.loadGame(withName:"games.json",withFolderName: "game")
            self.games.append(GameViewModel(game: game!))

        }
        
    }

    func loadPlayer() async  {
            let player = try? await Persistance.getPlayers(withName: "players.json", withFolderName: "player")

        print(player?.count)
            if let playerList = player {
                print(playerList.map { $0.name })
                self.players.append(contentsOf: playerList.map { PlayerVM(player: $0, image: Image("connect")) })
            }
    }
    }
