//
//  PlayerVM.swift
//  swift_UI
//
//  Created by etudiant on 26/05/2025.
//

import SwiftUI
import Connect4Core


class PlayerVM : ObservableObject,Identifiable {
    @Published var player : Player
    
    init(player: Player) {
        self.player = player
    }
    
        
}
