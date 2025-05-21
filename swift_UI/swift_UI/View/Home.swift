//
//  ContentView.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var naviguer = false
    @State private var naviguer2 = false

    //ToolBarItem
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.bg, .bg2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack {
                    Text("Home").navigationTitle("Home")
                    
                    Image("connect")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Rectangle())
                    
                    Text("Puissance 4")
                        .font(.custom("Short Baby", size: 32))
                    
                    Button(action: {
                        naviguer = true
                    }) {
                        Text("NOUVELLE PARTIE")
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    NavigationLink("", destination: NewParty(),isActive: $naviguer).hidden()
                    
                    Button(action: {
                        naviguer2 = true
                    }) {
                        Text("RESULTATS")
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    NavigationLink("", destination: HistoryBetweenPlayers(),isActive: $naviguer2).hidden()
                }
                .foregroundStyle(.main).ignoresSafeArea(.all).font(.custom("Short Baby", size: 16, relativeTo: .body))
                
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark) // ou .light

}
