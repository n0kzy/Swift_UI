//
//  ARKViewContainer.swift
//  swift_UI
//
//  Created by etudiant on 24/06/2025.
//

import SwiftUI
import RealityKit
import ARKit

struct MyARViewContainer: UIViewRepresentable {
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> ARView {
        return MyARView()
    }

}
