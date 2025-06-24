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
    @Published var image:Image?
    @Published var type:String
    init(player: Player,image:Image = Image("image_profile"),type:String = "Human") {
        self.player = player
        self.image = image
        self.type = type
    }
    
        
}
