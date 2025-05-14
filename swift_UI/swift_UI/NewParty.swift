//
//  NewParty.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI

struct NewParty: View {
    @State private var selectedItem = "Classique"
    
    // Liste des options
    let options = ["Classique", "Option 2", "Option 3", "Option 4"]
    var body: some View {
        VStack {
            Text("NOUVELLE PARTIE").font(.title).padding()
            
            HStack {
                VStack {
                    Text("JOUEUR 1")
                    Text("toto1")
                    Image("connect")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Rectangle())
                    HStack {
                        Image("connect")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .clipShape(Rectangle())
                        Text("modifier").tint(Color.main)
                    }
                }
                Spacer()
                VStack {
                    Text("JOUEUR 2")
                    Text("toto2")
                    Image("connect")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Rectangle())
                    HStack {
                        Image("connect")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .clipShape(Rectangle())
                        Text("modifier").tint(Color.main)
                    }
                }
                
            }.frame(maxWidth:.infinity).padding(.horizontal,50)
            HStack {
                Text("Règles du jeu")
                Picker("Choisissez une option", selection: $selectedItem) {
                        // Créer une option pour chaque élément de la liste
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
            }
            Button(action: {
            }) {
                Text("JOUER")
                    .padding()
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.main, lineWidth: 2)
                    )
            }
            }.frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    NewParty()
}
