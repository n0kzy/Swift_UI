//
//  swift_UIApp.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI
import Connect4Core
import Connect4Rules
@main
struct swift_UIApp: App {
    var body: some Scene {
        WindowGroup {
            let player1 = Player(withName: "test", andId: Owner.player1)!
            let player2 = Player(withName: "tata", andId: Owner.player2)!
            let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
            let coreGame = try! Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)
            
            let pers = PersistanceVM(games: [], players: [])
            Task {
                await pers.loadPlayer()
            }
            let viewModel = GameViewModel(game: coreGame)
            
            
            return NewParty(gameToLaunch: viewModel,pers:pers)
            
        }
    }
}
