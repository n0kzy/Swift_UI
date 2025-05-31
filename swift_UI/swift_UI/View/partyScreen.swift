//
//  partyScreen.swift
//  swift_UI
//
//  Created by etudiant on 17/05/2025.
//

import SwiftUI
import SpriteKit

struct partyScreen: View {
    let options = ["Classique", "Tic Tac Toe", "Morpion"]
    @State private var selectedItem = "Classique"
    @Binding var avatarImage: Image
    @Binding var avatarImage2: Image
    @Binding var game : GameViewModel
    //@Binding var timer : Timer
    //@State var selectedVal : String = game.game.type

    var scene : SKScene {
        let scene = GameScene()
        scene.size = CGSize(width:300 , height: 400)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        StyleView {
            ScrollView {
                SpriteView(scene: scene)
                VStack{
                    HStack{
                        PlayerView(image:avatarImage, playerName: "CodeLord", playerType: "Humain",color: .yellow)

                        PlayerView(image:avatarImage2, playerName: "Neptune", playerType: "IA",color: .red)

                        
                    }
                    //VGrid LazyGrid
                    VStack(spacing: 5) {
                        ForEach(0..<game.game.board.nbRows, id: \.self) { row in
                            HStack(spacing: 5) {
                                ForEach(0..<game.game.board.nbColumns , id: \.self) { col in
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
                    CustomPicker(selectedItem: $selectedItem, options: options, text: "Règles")
                    Text("\(game.game.editableData.type)")
                }
            }
        }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
    }
}
/*
#Preview {
    @State var avatarImage: Image = Image("connect")
    @State var avatarImage2: Image = Image("connect")
    partyScreen(avatarImage: $avatarImage, avatarImage2: $avatarImage2, game: <#Binding<GameViewModel>#>)
}
 */

