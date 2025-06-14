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
    @State var games : GamesVM
    @State var pers : PersistanceVM

    //@Binding var timer : Timer
    //@State var selectedVal : String = game.game.type

    var scene: GameScene {
        GameScene(
            size: CGSize(width: 700, height: 700),
            nbRows: game.game.board.nbRows,
            nbColumns: game.game.board.nbColumns
        )
    }

    var body: some View {
            StyleView {
                VStack {
                    VStack{
                        HStack{
                            PlayerView(image:avatarImage, playerName: game.game.players[.player1]!.name, playerType: "Humain",color: .yellow)
                            
                            PlayerView(image:avatarImage2, playerName: game.game.players[.player2]!.name, playerType: "IA",color: .red)
                            
                            
                        }.padding(50)
                        CustomButton(text: "test", execute: add) {
                            Historique(data: games)
                        }
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
                    }
                    VStack{
                        CustomPicker(selectedItem: $selectedItem, options: options, text: "Règles")
                        Text("\(game.game.editableData.type)")
                        CustomButton(text: "test", execute: add) {
                            Historique(data: games)
                        }

                    }
                }
            }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
    }
    func add()
    {
            games.update(with: game)
            pers.games.append(game)
        if let player = game.game.players[.player1] {
            let playerVM = PlayerVM(player: player, image: Image("connect")) // ou l'image que tu veux
            pers.players.append(playerVM)
        }
        if let player = game.game.players[.player1] {
            let playerVM = PlayerVM(player: player, image: Image("connect")) // ou l'image que tu veux
            pers.players.append(playerVM)
        }
        pers.saveGame()
        pers.savePlayers()
            
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

