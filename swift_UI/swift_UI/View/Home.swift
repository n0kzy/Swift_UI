//
//  ContentView.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI
import SpriteKit
struct HomeView: View {

    var body: some View {
            StyleView {
                
                VStack {
                    Text("Accueil").font(Font.custom("Short Baby", size: 32))
                    
                    Image("connect")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Rectangle())
                    
                    Text("Puissance 4")
                        .font(.custom("Short Baby", size: 32))
                    
                    CustomButton(text: "NOUVELLE PARTIE",destination: { NewParty() }).padding()
                    
                    CustomButton(text: "RESULTATS") {
                        HistoryBetweenPlayers()
                    }
            
                }
            }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)

}
