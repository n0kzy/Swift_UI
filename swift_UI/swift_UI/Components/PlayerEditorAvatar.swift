//
//  PlayerEditorAvatar.swift
//  swift_UI
//
//  Created by etudiant on 22/05/2025.
//

import SwiftUI
import PhotosUI

struct PlayerAvatarEditor: View {
    let playerLabel: String
    let playerName: String

    @Binding var avatarItem: PhotosPickerItem?
    @Binding var avatarImage: Image

    var body: some View {
        VStack {
            Text(playerLabel)
                .font(.caption)
                .foregroundColor(.gray)
            Text(playerName)
                .font(.headline)

            avatarImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())

            PhotosPicker("Modifier", selection: $avatarItem, matching: .images)
        }
        .onChange(of: avatarItem) { _ in
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                } else {
                    print("Échec du chargement de l'image.")
                }
            }
        }
    }
}
