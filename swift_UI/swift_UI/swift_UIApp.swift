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

            
            //return NewParty(gameToLaunch: viewModel)
            return HomeView()
            
            //MyARViewContainer()
        }
    }
}
