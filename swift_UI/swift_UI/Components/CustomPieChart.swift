//
//  CustomPieChart.swift
//  swift_UI
//
//  Created by etudiant on 24/05/2025.
//

import SwiftUI

struct GameStatsPieChart: View {
    let humanWins: CGFloat
    let aiWins: CGFloat
    let draws: CGFloat
    
    private var total: CGFloat {
        humanWins + aiWins + draws
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: humanWins / total)
                .stroke(Color.green, lineWidth: 20)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: humanWins / total, to: (humanWins + draws) / total)
                .stroke(Color.gray, lineWidth: 20)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: (humanWins + draws) / total, to: 1.0)
                .stroke(Color.red, lineWidth: 20)
                .rotationEffect(.degrees(-90))
            
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
}
