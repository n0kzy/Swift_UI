//
//  HistoryBetweenPlayers.swift
//  swift_UI
//
//  Created by etudiant on 19/05/2025.
//

import SwiftUI

struct HistoryBetweenPlayers: View {
    let matches = [
         ("10/04/25", "CodeLord", "Classiques"),
         ("10/04/25", "CodeLord", "Classiques"),
         ("10/04/25", "CodeLord", "Classiques")
     ]

    var body: some View {
        
        StyleView{
            
            VStack(spacing: 20) {
                // Titre
                Text("Face a Face")
                    .font(Font.custom("Short Baby", size: 32))                
                // Ligne avatars + score
                HStack {
                    PlayerView(image:Image(systemName: "person.crop.circle"), playerName: "CodeLord", playerType: "Humain")
                    
                    Spacer()
                    
                    VStack {
                        GameStatsPieChart(humanWins: 5, aiWins: 3, draws: 2)
                    }
                    
                    Spacer()
                    
                    PlayerView(image:Image(systemName:"brain.head.profile"), playerName: "Neptune", playerType: "IA")

                }
                .padding(.horizontal)
                CustomStats(titles: ("Date","Vainqueur","Règles"), matches: matches)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HistoryBetweenPlayers()

}
