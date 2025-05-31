//
//  GamesVM.swift
//  swift_UI
//
//  Created by etudiant on 28/05/2025.
//

import SwiftUI
import Connect4Core

class GamesVM: ObservableObject {
    let id = UUID()
    @Published var games : [GameViewModel]
    private var gamesData: [Game.Data] = []


    init(with games: [Game]) {
        self.games = games.map { GameViewModel(game: $0) }
    }

    
    func save() {
        gamesData = games.map { $0.editableData }

        do {
            let json = URL.documentsDirectory.appending(path:"Games.json")
            let gamesData = try JSONEncoder().encode(gamesData)
            try gamesData.write(to: json)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func load() {
        let json = URL.documentsDirectory.appending(path:"Games.json")
        if FileManager().fileExists(atPath: json.path) {
            do {
                let data = try Data(contentsOf: json)
                gamesData = try JSONDecoder().decode([Game.Data].self, from:data)
            } catch {
                print(error.localizedDescription)
            }
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

