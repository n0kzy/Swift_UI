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
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.bg, .bg2]),
                           startPoint: .top,
                           endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Titre
                Text("Face a Face")
                    .font(Font.custom("Short Baby", size: 32))                
                // Ligne avatars + score
                HStack {
                    // Humain
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("CodeLord")
                            .font(.headline)
                        Text("Humain")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack {
                        ZStack {
                            // Total = 10 parties (par ex.)
                            let total: CGFloat = 10
                            let humanWins: CGFloat = 5
                            let aiWins: CGFloat = 3
                            let draws: CGFloat = total - humanWins - aiWins
                            
                            // Segment joueur (vert)
                            Circle()
                                .trim(from: 0.0, to: humanWins / total)
                                .stroke(Color.green, lineWidth: 20)
                                .rotationEffect(.degrees(-90))
                            
                            // Segment égalités (gris)
                            Circle()
                                .trim(from: humanWins / total, to: (humanWins + draws) / total)
                                .stroke(Color.gray, lineWidth: 20)
                                .rotationEffect(.degrees(-90))
                            
                            // Segment IA (rouge)
                            Circle()
                                .trim(from: (humanWins + draws) / total, to: 1.0)
                                .stroke(Color.red, lineWidth: 20)
                                .rotationEffect(.degrees(-90))
                            
                            // Texte au centre
                            VStack {
                                Text("\(Int(humanWins)) - \(Int(aiWins))")
                                    .font(.headline)
                                Text("\(Int(draws)) nul\(draws > 1 ? "s" : "")")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(width: 100, height: 100)
                    }
                    
                    Spacer()
                    
                    // IA
                    VStack {
                        Image(systemName: "brain.head.profile")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Neptune")
                            .font(.headline)
                        Text("IA")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                // Tableau
                VStack(alignment: .leading) {
                    HStack {
                        Text("Date").bold().underline()
                        Spacer()
                        Text("Vainqueur").bold().underline()
                        Spacer()
                        Text("Règles").bold().underline()
                    }
                    .padding(.horizontal)
                    
                    ForEach(matches, id: \.0) { match in
                        HStack {
                            Text(match.0)
                            Spacer()
                            Text(match.1)
                            Spacer()
                            Text(match.2)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
                
                Spacer()
            }
            .padding()
        }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
    }
}

#Preview {
    HistoryBetweenPlayers()

}
