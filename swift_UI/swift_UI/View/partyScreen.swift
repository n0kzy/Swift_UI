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
    
    @ObservedObject var pers : PersistanceVM
    //@Binding var timer : Timer
    //@State var selectedVal : String = game.game.type
    @State var min: Int = 60
    @State var sec : Int = 0
    @State var val = 0
    @State var timer = Timer()

    var scene: GameScene {
        GameScene(
            size: CGSize(width: 700, height: 700),
            gameViewModel: game
        )
    }

    var body: some View {
            StyleView {
                VStack {
                    VStack{
                        HStack{
                            PlayerView(image:avatarImage, playerName: game.game.players[.player1]!.name, playerType:game.p1.type,color: .yellow)
                            
                            PlayerView(image:avatarImage2, playerName: game.game.players[.player2]!.name, playerType:game.p2.type,color: .red)
                            
                            
                        }.padding(50)

                        //VGrid LazyGrid
                        VStack {
                            GeometryReader { geometry in
                                let availableSize = geometry.size
                                let adjustedSize = foundSize(containerSize: availableSize, scene.size)
                                
                                SpriteView(scene: scene)
                                    .scaledToFit()
                                    .frame(width:adjustedSize.width , height:adjustedSize.height )
                                    .position(x: availableSize.width / 2, y: availableSize.height / 2)
                            }.ignoresSafeArea()
                        }.frame(width: 300, height: 300)
                    }
                    .padding(.bottom)
                    
                    Button(action: {
                        print("Pause")
                    }){
                        Image(systemName: "pause.fill")
                        Text(String(val))
                    }
                }
            }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
            .onAppear {
                val = min * 60 + sec
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if val > 0 {
                        val -= 1
                    }
                 }
             }
    }
    func add()
    {
        Task {
            await pers.loadResults()
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

