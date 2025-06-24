//
//  ARGameManager.swift
//  swift_UI
//
//  Created by etudiant on 24/06/2025.
//

import Foundation
import RealityKit
import Connect4Core
import Connect4Rules
import UIKit

class ARGameManager {
    private let arView: MyARView
    private let anchor: AnchorEntity
    private var currentPlayer: Owner = .player1
    private let gameViewModel: GameViewModel

    init(arView: MyARView, gameViewModel: GameViewModel) {
        self.arView = arView
        self.gameViewModel = gameViewModel

        anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2(0.2, 0.2)))
        arView.scene.addAnchor(anchor)

        setupBoard()
    }

    private func setupBoard() {
        for row in 0..<6 {
            for col in 0..<7 {
                arView.loadObject(named: "Cell", in: anchor, at: SIMD3(0, Float(row)*2, Float(col)*2))

                
            }
        }
        anchor.scale = SIMD3(1, 1, 1)
    }

    func playMove(column: Int) async {
        let row = await gameViewModel.playMove(column: column)

        guard row >= 0 else {
            print("Colonne pleine")
            return
        }

        let token = createToken(for: currentPlayer)
        let finalPosition = SIMD3<Float>(0, Float(row) * 2, Float(column) * 2)
        let startPosition = finalPosition + SIMD3<Float>(0, 20, 0)
        token.position = startPosition
        await anchor.addChild(token)

        // Anime la chute
        let duration: Float = 0.3
        var transform = await token.transform
        transform.translation = finalPosition
        await token.move(to: transform, relativeTo: anchor, duration: TimeInterval(duration), timingFunction: .easeOut)

        // Change le joueur
        currentPlayer = (currentPlayer == .player1) ? .player2 : .player1
    }

    private func createToken(for player: Owner) -> ModelEntity {
        let color: UIColor = (player == .player1) ? .yellow : .red
        let token = try! ModelEntity.loadModel(named: "Token")
        token.generateCollisionShapes(recursive: true)

        // Change la couleur
        var material = SimpleMaterial()
        material.color = .init(tint: color, texture: nil)
        token.model?.materials = [material]

        return token
    }
}
