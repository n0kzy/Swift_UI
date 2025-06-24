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
    @State var pers : PersistanceVM
    var body: some View {
        VStack {
            Text(player.label)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(LocalizedStringKey("name"),text: $player.name)
                .multilineTextAlignment(.center)
                .font(.headline)

            player.avatarImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())

            PhotosPicker(LocalizedStringKey("Modifier"), selection: $player.avatarItem, matching: .images)
            
            Picker(LocalizedStringKey("Choisir joueur 1"), selection: $player.name) {
                ForEach(pers.players.map { $0.player.name }, id: \.self) { name in
                    Text(name).tag(name)
                }
            }
        }
        .onChange(of: player.avatarItem) { _ in
            Task {
                if let loaded = try? await player.avatarItem?.loadTransferable(type: Image.self) {
                    player.avatarImage = loaded
                } else {
                    print(LocalizedStringKey("Échec du chargement de l'image."))
                }
            }
        }
    }
}
