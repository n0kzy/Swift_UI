//
//  ContentView.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            VStack {
                Image("connect")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Rectangle())
                
                Text("Puissance 4").font(.title)
                
                Button(action: {
                }) {
                    Text("NOUVELLE PARTIE")
                        .padding()
                        .foregroundColor(.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                
                Text("RESULTATS")
                    .padding()
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 2)
                    )

            }
            .foregroundColor(.main)
            .padding()
        }
}

#Preview {
    ContentView()
}
