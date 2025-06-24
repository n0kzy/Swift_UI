//
//  TempPlayerData.swift
//  swift_UI
//
//  Created by etudiant on 12/06/2025.
//

import _PhotosUI_SwiftUI
import SwiftUICore

struct TempPlayerData : Equatable {
    var name: String = ""
    var avatarImage: Image = Image("image_profile")
    var avatarItem: PhotosPickerItem? = nil
    var label = "Joueur 1"
    var type = "Human"
}
