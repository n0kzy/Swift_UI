//
//  NewParty.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI
import PhotosUI
import Connect4Core

struct NewParty: View {
    @State private var selectedItem = "Classique"
    @State private var selectedType = "Player"
    @State private var lignes = 6
    @State private var jetons = 4
    @State private var colonnes = 7
    @State private var secondesInput: String = "0"
    @State private var minutesInput: String = "1"
    @State private var avatarItem: PhotosPickerItem?
    @State var avatarImage: Image = Image("image_profile")
    @State private var avatarItem2: PhotosPickerItem?
    @State var avatarImage2: Image = Image("image_profile")
    @State private var naviguer:Bool = false
    
    @State var gameToLaunch: GameViewModel
    
    @ObservedObject var joueur: PlayerVM = PlayerVM(player: Player(withName: "toto", andId: Owner.player1)!)
    @ObservedObject var joueur2: PlayerVM = PlayerVM(player: Player(withName: "toto2", andId: Owner.player2)!)
    
    // Liste des options
    let options = ["Classique", "Tic Tac Toe", "Morpion"]
    let typePlayer = ["Player","IA"]
    var body: some View {
        StyleView{
            ScrollView {
                VStack {
                    Text("NOUVELLE PARTIE").font(Font.custom("Short Baby",size:32)).padding()
                    
                    HStack {
                        PlayerAvatarEditor(
                            playerLabel: "JOUEUR 1",
                            playerName: joueur.player.name,
                            avatarItem: $avatarItem,
                            avatarImage: $avatarImage
                        )
                        Spacer()
                        
                        VStack {
                            PlayerAvatarEditor(
                                playerLabel: "JOUEUR 2",
                                playerName: joueur2.player.name,
                                avatarItem: $avatarItem2,
                                avatarImage: $avatarImage2
                            )
                            CustomPicker(selectedItem: $selectedType, options: typePlayer, text: "joueur")
                        }
                        
                        
                    }.frame(maxWidth:.infinity).padding(.horizontal,50)
                    Divider()
                    CustomPicker(selectedItem: $selectedItem, options: options, text: "Règles")
                    Grid(alignment: .leading, horizontalSpacing: 15, verticalSpacing: 10) {
                        
                        GridRow {
                            Text("Dimensions :")
                                .gridCellAnchor(.topLeading)
                            EmptyView()
                        }
                        ForEach([("Lignes", $lignes), ("Colonnes", $colonnes), ("Jetons", $jetons)], id: \.0) { name, value in
                            GridRow {
                                Text(name)
                                TextField(name, value: value, formatter: NumberFormatter())
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.trailing,20)
                                Stepper("",value: value, step: 1).frame(width: 50,height: 50)
                            }
                        }
                    }
                    
                    HStack {
                        Text("limite de temps:")
                        TextField("0", text: $minutesInput)
                            .frame(width: 40)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("min")
                        TextField("0", text: $secondesInput)
                            .frame(width: 40)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("sec")
                    }
                    CustomButton(text: "JOUER", execute:createGame, destination: {
                        
                        partyScreen(avatarImage: $avatarImage, avatarImage2: $avatarImage2, game:$gameToLaunch)
                        
                    })
                }
            }
        }
    }
        func createGame() {
            do {
                //if(selectedItem == "Tic Tac Toe"){
                    let rules = Connect4Rules(nbRows: lignes, nbColumns: colonnes, nbPiecesToAlign: jetons)!
                //}
                    let coreGame = try? Connect4Core.Game(withRules: rules, andPlayer1: joueur.player, andPlayer2: joueur2.player)
                gameToLaunch = GameViewModel(game: coreGame!)
            }
        }
    }

    
#Preview {
    let player1 = Player(withName: "toto", andId: Owner.player1)!
    let player2 = Player(withName: "tata", andId: Owner.player2)!
    let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
    let coreGame = try! Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)
    
    let viewModel = GameViewModel(game: coreGame)
    
    let joueurVM = PlayerVM(player: player1)
    
    return NewParty(gameToLaunch: viewModel, joueur: joueurVM)
        .preferredColorScheme(.dark)
}

