//
//  ARView.swift
//  swift_UI
//
//  Created by etudiant on 24/06/2025.
//



import SwiftUI
import ARKit
import RealityKit

class MyARView: ARView {
    
    var gameManager: ARGameManager?

    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        applyConfiguration()
        createBoard()
        setupGameManager(with: GameViewModel())
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    convenience init() {
         self.init(frame: UIScreen.main.bounds)
        applyConfiguration()
        createBoard()
        setupGameManager(with: GameViewModel())
     }

     func setupGameManager(with viewModel: GameViewModel) {
         self.gameManager = ARGameManager(arView: self, gameViewModel: viewModel)
     }
    
    func applyConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
//        let configuration = ARGeoTrackingConfiguration()
//        let configuration = ARFaceTrackingConfiguration()
//        let configuration = ARBodyTrackingConfiguration()
        session.run(configuration)
    }
    
    func defineAnchors() {
        let anchor = AnchorEntity(world: .zero)
//        let anchor = AnchorEntity(.camera)
//        let anchor = AnchorEntity(plane: .horizontal)
//        let anchor = AnchorEntity(plane: .vertical)
//        let anchor = AnchorEntity(.face)
//        let anchor = AnchorEntity(.body)
//        let anchor = AnchorEntity(.image(group: "group", name: "name"))
        
        scene.addAnchor(anchor)
    }
    
    var initialTransform: Transform = Transform()

    @objc private func handleGesture(_ recognizer: UIGestureRecognizer) {
        guard let translationGesture = recognizer as? EntityTranslationGestureRecognizer, let entity = translationGesture.entity else { return }
            
            switch translationGesture.state {
            case .began:
                self.initialTransform = entity.transform
            default:
                break
            }
    }
    
    @discardableResult
    func loadObject(named name: String, in anchor: AnchorEntity, at position: SIMD3<Float> = SIMD3(0.0, 0.0, 0.0), scale: SIMD3<Float> = SIMD3(1, 1, 1)) -> ModelEntity? {
        let entity = try? Entity.loadModel(named: name)
        if let entity {
            entity.scale = scale
            entity.position = position
            anchor.addChild(entity)
        }
        return entity
    }
    
    
    func createBoard() {
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        scene.addAnchor(anchor)
        for row in (0..<6) {
            for col in (0..<7) {
                loadObject(named: "Cell", in: anchor, at: SIMD3(0, Float(row)*2, Float(col)*2))
            }
        }
        
        
        loadObject(named: "LeftFoot", in: anchor)
        loadObject(named: "RightFoot", in: anchor, at: SIMD3(0.0, 0.0, 12))
        
        loadObject(named: "Token", in: anchor, at: SIMD3(0, 0, 0))
        loadObject(named: "Token", in: anchor, at: SIMD3(0, 0, 4))
        loadObject(named: "Token", in: anchor, at: SIMD3(0, 0, 10))
        loadObject(named: "Token", in: anchor, at: SIMD3(0, 2, 4))
        loadObject(named: "Token", in: anchor, at: SIMD3(0, 2, 10))
        loadObject(named: "Token", in: anchor, at: SIMD3(0, 4, 4))
        
        if let robot = try? Entity.loadModel(named: "Token") {
            robot.generateCollisionShapes(recursive: true)

            // Geste de déplacement (drag)
            self.installGestures([.translation], for: robot as Entity & HasCollision)

            anchor.addChild(robot)
        }
        
        anchor.transform.rotation = simd_quatf(angle: GLKMathDegreesToRadians(90), axis: SIMD3(0, 1, 0))
        anchor.scale = SIMD3(0.02, 0.02, 0.02)
    }

}
    
