//
//  PlayerEditorAvatar.swift
//  swift_UI
//
//  Created by etudiant on 22/05/2025.
//

import SwiftUI
import PhotosUI

struct PlayerAvatarEditor: View {
    //let playerLabel: String
    //var playerName: String

    //@Binding var avatarItem: PhotosPickerItem?
    //@Binding var avatarImage: Image
    
    @Binding var player : TempPlayerData

    var body: some View {
        VStack {
            Text(player.label)
                .font(.caption)
                .foregroundColor(.gray)
            TextField("name",text: $player.name)
                .multilineTextAlignment(.center)
                .font(.headline)

            player.avatarImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())

            PhotosPicker("Modifier", selection: $player.avatarItem, matching: .images)
        }
        .onChange(of: player.avatarItem) { _ in
            Task {
                if let loaded = try? await player.avatarItem?.loadTransferable(type: Image.self) {
                    player.avatarImage = loaded
                } else {
                    print("Échec du chargement de l'image.")
                }
            }
        }
    }
}
