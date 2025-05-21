//
//  partyScreen.swift
//  swift_UI
//
//  Created by etudiant on 17/05/2025.
//

import SwiftUI

struct partyScreen: View {
    let options = ["Classique", "Option 2", "Option 3", "Option 4"]
    @State private var selectedItem = "Classique"
    let rows = 6
    let columns = 7
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.bg, .bg2]),
                           startPoint: .top,
                           endPoint: .bottom).ignoresSafeArea()
            ScrollView {
                VStack{
                    HStack{
                        Image("connect")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        VStack {Text("joueur 1")
                            Text("Human").font(.subheadline)
                        }
                        VStack {Text("joueur 2")
                            Text("IA").font(.subheadline)
                        }
                        Image("connect")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                    }
                    //VGrid LazyGrid
                    VStack(spacing: 5) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 5) {
                                ForEach(0..<columns, id: \.self) { col in
                                    Button(action: {
                                        
                                    }) {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.black, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(12)
                }.padding()
                
                Button(action: {
                    print("Pause")
                }){
                    Image(systemName: "pause.fill")
                }
                VStack{
                    HStack{
                        Text("Règles du jeu : ")
                        Picker("choix", selection: $selectedItem){
                            ForEach(options, id: \.self) { option in
                                Text(option)
                            }
                        }
                    }
                }
            }
        }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
    }
}
#Preview {
    partyScreen()
}
