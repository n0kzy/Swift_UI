//
//  PlayerVM.swift
//  swift_UI
//
//  Created by etudiant on 26/05/2025.
//

import SwiftUI
import Connect4Core


class PlayerVM : ObservableObject,Identifiable,Equatable {
    static func == (lhs: PlayerVM, rhs: PlayerVM) -> Bool {
        lhs.player.id == rhs.player.id
    }
    
    @Published var player : Player
    @Published var image:Image?
    
    init(player: Player,image:Image) {
        self.player = player
        self.image = image
    }
    
        
}
