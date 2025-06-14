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
    @State private var naviguer:Bool = false
    @State private var player1 = TempPlayerData()
    @State private var player2 = TempPlayerData(label:"Joueur 2")
    @State var gameToLaunch: GameViewModel
    
    @StateObject var games = GamesVM(with: [])
    @StateObject var pers : PersistanceVM
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
                            player:$player1
                        )
                        Picker("Choisir joueur 1", selection: $player1.name) {
                              ForEach(pers.players.map { $0.player.name }, id: \.self) { name in
                                  Text(name).tag(name)
                              }
                          }
                          .pickerStyle(MenuPickerStyle())
                        Spacer()
                        
                        VStack {
                            PlayerAvatarEditor(
                                player:$player2

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
                    CustomButton(text: "JOUER", execute:{
                        Task {
                            await createGame()
                        }
                    }, destination: {
                        
                        partyScreen(avatarImage: $player1.avatarImage, avatarImage2: $player2.avatarImage, game:$gameToLaunch,games: games, pers: pers)
                        
                    })
                }

            }
        } .task {
            await pers.loadPlayer()
            if let first = pers.players.first {
                player1.name = first.player.name
            }
            if let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                print("Documents directory: \(documents.path)")
            }
        }
    }
    func createGame () async {
            do {
                    await pers.loadPlayer()
                print("pass pas")
                print(pers.players.count)
                if let firstPlayer = pers.players.first {
                    print("pass")
                    player1.name = firstPlayer.player.name
                }
                guard let p1 = Player(withName: player1.name, andId: Owner.player1),
                      let p2 = Player(withName: player2.name, andId: Owner.player2) else {
                    print("Erreur de création des joueurs")
                    return
                }

                let joueur1 = PlayerVM(player: p1, image: player1.avatarImage)
                let joueur2 = PlayerVM(player: p2, image: player2.avatarImage)

                //if(selectedItem == "Tic Tac Toe"){
                    let rules = Connect4Rules(nbRows: lignes, nbColumns: colonnes, nbPiecesToAlign: jetons)!
                //}
                    let coreGame = try? Connect4Core.Game(withRules: rules, andPlayer1: joueur1.player, andPlayer2: joueur2.player)
                gameToLaunch = GameViewModel(game: coreGame!)

            }
        }
    }

    
#Preview {
    //let pers = PersistanceVM(games: [], players: [])
    let player1 = Player(withName: "test", andId: Owner.player1)!
    let player2 = Player(withName: "tata", andId: Owner.player2)!
    let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
    let coreGame = try! Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)

    let pers = PersistanceVM(games: [], players: [])
    Task {
        await pers.loadPlayer()
    }
    let viewModel = GameViewModel(game: coreGame)
    
    
    return NewParty(gameToLaunch: viewModel,pers:pers)
    //permet de partager un objet ObservableObject à travers toute la hiérarchie des vues, sans avoir à le passer explicitement en paramètre à chaque vue
        .preferredColorScheme(.dark)
}

