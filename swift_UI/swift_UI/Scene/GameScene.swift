//
//  GameScene.swift
//  swift_UI
//
//  Created by etudiant on 25/05/2025.
//

import SwiftUI
import SpriteKit
class GameScene: SKScene, SKPhysicsContactDelegate {
    let player = SKSpriteNode(imageNamed: "connect")
    
    var gameTimer : Timer?
    
    func startGame() {
        //dit au timer d'arreter de ce délcencher
        gameTimer?.invalidate()
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) {
            _ in 
        }
    }
    
}
