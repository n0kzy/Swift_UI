//
//  PlayerView.swift
//  swift_UI
//
//  Created by etudiant on 22/05/2025.
//

import SwiftUI

struct PlayerView: View {
    let image: Image
    let playerName: String
    let playerType: String
    var color:Color?
    var body: some View {
        ZStack {
            VStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .clipShape(Circle())
                Text(playerName)
                    .font(.headline)
                Text(LocalizedStringKey(playerType))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            if (color != nil) {
                Circle()
                    .fill(color!)
                    .frame(width: 20, height: 20)
                    .padding(.init(top: 40, leading: 60, bottom: 0, trailing: 0))

            }
        }
    }
}

