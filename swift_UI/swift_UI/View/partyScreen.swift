//
//  partyScreen.swift
//  swift_UI
//
//  Created by etudiant on 17/05/2025.
//

import SwiftUI
import SpriteKit
import Connect4Persistance

struct partyScreen: View {
    @Binding var avatarImage: Image
    @Binding var avatarImage2: Image
    @Binding var game : GameViewModel
    @State var min: Int = 60
    @State var sec : Int = 0
    @State var val = 0
    @State var timer = Timer()

    @State private var gameScene: GameScene? = nil

    var body: some View {
            StyleView {
                VStack {
                    VStack{
                        HStack{
                            PlayerView(image:avatarImage, playerName: game.game.players[.player1]!.name, playerType:game.p1.type,color: .yellow)
                            PlayerView(image:avatarImage2, playerName: game.game.players[.player2]!.name, playerType:game.p2.type,color: .red)

                        }.padding(40)
 
                        //VGrid LazyGrid
                        VStack {
                            GeometryReader { geometry in
                                if let scene = gameScene {
                                    let availableSize = geometry.size
                                    let adjustedSize = foundSize(containerSize: availableSize, gameScene!.size)
                                    
                                    SpriteView(scene: scene)
                                        .scaledToFit()
                                        .frame(width:adjustedSize.width , height:adjustedSize.height )
                                        .position(x: availableSize.width / 2, y: availableSize.height / 2)
                                }
                                else {
                                    ProgressView("Chargement de la scène…")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                            }.ignoresSafeArea()
                        }.frame(width: 300, height: 300)
                    }
                    .padding(.bottom)
                    
                    if val > 0 {
                          Button(action: {
                              print("Pause")
                          }) {
                              Image(systemName: "pause.fill")
                              Text(String(val))
                          }
                      } else {
                          Button(action: {
                              val = min * 60 + sec
                              Task {
                                  try await game.startEditing()
                              }
                          }) {
                              Label("Rejouer", systemImage: "arrow.clockwise")
                          }
                          .padding()
                          .background(Color.green)
                          .foregroundColor(.white)
                          .cornerRadius(8)
                      }
                    
                    CustomButton(text: "Historique", destination: { Historique() } )
                }
            }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
            .onAppear {
                val = min * 60 + sec
                gameScene = GameScene(
                     size: CGSize(width: 700, height: 700),
                     gameViewModel: game
                 )
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if val > 0 {
                        val -= 1
                    } else {
                        gameScene!.displayEndMessage("Temps écoulé")
                    }
                 }
             }
    }
 
    func foundSize(containerSize:CGSize, _ sceneSize:CGSize) -> CGSize {
        let containerRat = containerSize.width / containerSize.height
        let sceneRat = sceneSize.width / sceneSize.height
        if sceneRat >= containerRat {
            return CGSize(width:containerSize.width,height:containerSize.height)
        }
        else {
            return CGSize(width:containerSize.width*sceneSize.width,height:containerSize.height)
        }
    }

}
/*
#Preview {
    @State var avatarImage: Image = Image("connect")
    @State var avatarImage2: Image = Image("connect")
    partyScreen(avatarImage: $avatarImage, avatarImage2: $avatarImage2, game: <#Binding<GameViewModel>#>)
}
 */

