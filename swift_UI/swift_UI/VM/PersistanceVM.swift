//
//  PersistanceVM.swift
//  swift_UI
//
//  Created by etudiant on 12/06/2025.
//

import SwiftUI
import Connect4Core
import Connect4Rules
import Connect4Persistance
import Connect4Players

public class PersistanceVM : ObservableObject {
    
    static let shared = PersistanceVM()
    
    @Published var results : [GameResult]
    @Published var players : [PlayerVM]
    
    init(results: [GameResult] = [], players: [HumanPlayer] = []) {
            self.results = results
            self.players = players.map { PlayerVM(player: $0, image: Image("connect")) }
        }
        
    func saveResult(for game: Game, result: Result) async {
            do {
                let success = try await Persistance.saveGameResult(
                    withName: "results.json",
                    andGame: game,
                    andResult: result,
                    withFolderName: "game"
                )
            } catch {
                print("Erreur de sauvegarde du résultat : \(error)")
            }
        }
    
    
    func saveGame(game:Game) async {
        do {
            try await Persistance.saveGame(withName: "game", andGame: game,withFolderName: "game")
            
        } catch {
            print("erreur lors de la sauvegarde de la game")
        }
        
    }
    func deleteGame() async {
        do {
            try await Persistance.deleteGame(withName: "game", withFolderName: "game")
            
        } catch {
            print("erreur lors de la suppression de la game")
        }
    }

        @MainActor
        func loadResults() async {
            do {
                if let results = try await Persistance.loadGameResults(
                    withName: "results.json",
                    withFolderName: "game"
                ) {
                    self.results = results
                } else {
                    print("Aucun résultat trouvé.")
                }
            } catch {
                print("Erreur de chargement des résultats : \(error)")
            }
        }
    @MainActor
    func savePlayers() async throws {
            for p in players {
                do {
                    try await Persistance.addPlayer(withName: "players.json", andPlayer: p.player, withFolderName: "player")
                    let img = ImageRenderer(content: p.image).uiImage!
                    if p.image != nil && p.image != Image("image_profile") {
                        saveImage(img, name: p.player.name)
                    }
                    }
                    
                }
            
        }
    
    func createImgFolder() -> URL {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("players_images")

        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        }
        return folder
    }
    func saveImage(_ image: UIImage, name: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }

        let folder = createImgFolder()
        let filename = folder.appendingPathComponent("\(name).jpg")

        do {
            try data.write(to: filename)
            return filename
        } catch {
            print("Erreur sauvegarde image : \(error)")
            return nil
        }
    }

    
    func addPlayer(_ player: PlayerVM) {
        guard !players.contains(where: { $0.player.name == player.player.name }) else {
            print("Joueur déjà existant : \(player.player.name)")
            return
        }
        players.append(player)
    }

    @MainActor
    func loadPlayer() async -> [Player] {
        do {
            let playerList = try await Persistance.getPlayers(withName: "players.json", withFolderName: "player")
            
            if let playerList {
                self.players.append(contentsOf: playerList.map {
                    let img = loadPlayerImg(playerName: $0.name)
                    return PlayerVM(player: $0, image: img)
                })
                return playerList
            }
        } catch {
            print("Erreur lors du chargement des joueurs : \(error)")
        }
        return []
    }

    func loadPlayerImg(playerName : String) -> Image {
        let folder = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("players_images")
        let file = folder.appendingPathComponent("\(playerName).jpg")
        if let data = try? Data(contentsOf: file),
            let uiImage = UIImage(data: data) {
             return Image(uiImage: uiImage)
         }
        else {
                return Image("image_profile")
            }
    }
    }
