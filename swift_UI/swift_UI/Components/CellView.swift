//
//  CellView.swift
//  swift_UI
//
//  Created by etudiant on 24/05/2025.
//

import SwiftUI
import Connect4Core

struct CellView: View {
    var piece: Piece?

    var body: some View {
        Circle()
            .fill(color(for: piece))
            .frame(width: 40, height: 40)
    }

    func color(for piece: Piece?) -> Color {
        switch piece {
        case .some(.init(withOwner: .player1)):
            return .red
        case .some(.init(withOwner: .player2)):
            return .yellow
        default:
            return .white
        }
    }
}
