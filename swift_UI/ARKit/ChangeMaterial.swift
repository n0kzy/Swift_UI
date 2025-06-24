//
//  ChangeMaterial.swift
//  swift_UI
//
//  Created by etudiant on 24/06/2025.
//


import RealityKit

extension ModelEntity {
    func apply(material: Material) {
        self.model?.materials[0] = material
    }
}

