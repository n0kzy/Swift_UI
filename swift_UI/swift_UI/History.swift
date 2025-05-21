//
//  Historique.swift
//  swift_UI
//
//  Created by etudiant on 18/05/2025.
//

import SwiftUI

struct Historique: View {
    var body: some View {
        ScrollView{
            
            Text("Parties Enregistrées").font(.title).padding()
            
            VStack{
                Text("en cours").font(.subheadline)
                
                
                Text("terminées").font(.subheadline)
            }
        }
    }
}

#Preview {
    Historique()
}
