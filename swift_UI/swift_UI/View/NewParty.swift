//
//  NewParty.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI
import PhotosUI
import Connect4Core
import Connect4Rules

struct NewParty: View {
    @State private var selectedItem = "Classique"
    @State private var lignes = 6
    @State private var jetons = 4
    @State private var colonnes = 7
    @State private var secondesInput: Int = 0
    @State private var minutesInput = 1
    @State private var naviguer:Bool = false
    @State private var player1 = TempPlayerData()
    @State private var player2 = TempPlayerData(label:"Joueur 2")
    @State var gameToLaunch = GameViewModel()
    
    //
    @ObservedObject var pers : PersistanceVM
    //@ObservedObject var persistanceVM: PersistanceVM
    
    // Liste des options
    let options = ["Classique", "Tic Tac Toe", "PopOut"]
    let typePlayer = ["Human", "Random", "Finnish Him", "Simple NegaMax"]
    var body: some View {
        StyleView{
            ScrollView {
                VStack {
                    Text("NOUVELLE PARTIE").font(Font.custom("Short Baby",size:32)).padding()
                    HStack {
                        VStack {
                            PlayerAvatarEditor(
                                player:$player1,
                                pers:pers
                            )
                            
                            .pickerStyle(MenuPickerStyle())
                            CustomPicker(selectedItem:$player1.type, options: typePlayer, text: "joueur")
                        }
                        Spacer()
                        
                        VStack {
                            PlayerAvatarEditor(
                                player:$player2,
                                pers:pers
                                
                            )
                            .pickerStyle(MenuPickerStyle())
                            
                            CustomPicker(selectedItem:$player2.type, options: typePlayer, text: "joueur")
                            
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
                                Text(LocalizedStringKey(name))
                                TextField(LocalizedStringKey(name), value: value, formatter: NumberFormatter())
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50)
                                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.trailing,20)
                                Stepper("",value: value, step: 1).frame(width: 50,height: 50)
                            }
                        }
                    }
                    
                    HStack {
                        Text("limite de temps:")
                        TextField("0", text:
                            Binding(
                                get: { String(minutesInput) },
                                set: { newValue in
                                    minutesInput = Int(newValue) ?? 0
                                }))
                            .frame(width: 40)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("min")
                        TextField("0", text:
                            Binding(
                            get: { String(secondesInput) },
                            set: { newValue in
                                secondesInput = Int(newValue) ?? 0
                            }))
                            .frame(width: 40)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("sec")
                    }
                    CustomButton(text: "JOUER", execute:{
                        createGame()
                    }, destination: {
                        
                        partyScreen(avatarImage: $player1.avatarImage, avatarImage2: $player2.avatarImage, game:$gameToLaunch, pers: pers,min : minutesInput,sec : secondesInput)
                        
                    })
                }
                
            }
        } .task {
            await pers.loadPlayer()
            let p1 = pers.players.first(where: { $0.player.id == .player1 })
            let p2 = pers.players.first(where: { $0.player.id == .player2 })
            player1.name = p1?.player.name ?? ""
            player2.name = p2?.player.name ?? ""
            player1.avatarImage = p1?.image ?? Image("profile_image")
            player2.avatarImage = p2?.image ?? Image("profile_image")
            
        }
        .onChange(of: player1.name) { newName in
            if let p1 = pers.players.first(where: { $0.player.name == newName }) {
                player1.avatarImage = p1.image ?? Image("profile_image")
            } else {
                player1.avatarImage = Image("profile_image")
            }
        }
        .onChange(of: player2.name) { newName in
            if let p2 = pers.players.first(where: { $0.player.name == newName }) {
                player2.avatarImage = p2.image ?? Image("profile_image")
            } else {
                player2.avatarImage = Image("profile_image")
            }
        }

    }

    func createGame ()  {
            do {
                guard let p1 = GameViewModel.choosePlayerTypeAndName(.player1, type: player1.type, name: player1.name),
                      let p2 = GameViewModel.choosePlayerTypeAndName(.player2, type: player2.type, name: player2.name) else {
                    print("Erreur de création des joueurs")
                    return
                }
                
                let joueur1 = PlayerVM(player: p1, image: player1.avatarImage,type: player1.type)
                let joueur2 = PlayerVM(player: p2, image: player2.avatarImage,type: player2.type)
                pers.players.append(joueur1)
                pers.players.append(joueur2)
                Task {
                    try await pers.savePlayers()
                }
                var rules: Rules? = nil

                if selectedItem == "Tic Tac Toe" {
                    rules = TicTacToeRules(nbRows: lignes, nbColumns: colonnes, nbPiecesToAlign: jetons)
                    if rules == nil {
                        print("Erreur création règles Tic Tac Toe")
                    }
                } else if selectedItem == "PopOut" {
                    rules = PopOutRules(nbRows: lignes, nbColumns: colonnes, nbPiecesToAlign: jetons)
                    if rules == nil {
                        print("Erreur création règles PopOut")
                    }
                } else {
                    rules = Connect4Rules(nbRows: lignes, nbColumns: colonnes, nbPiecesToAlign: jetons)
                    if rules == nil {
                        print("Erreur création règles Connect4")
                    }
                }

                    
                let coreGame = try? Connect4Core.Game(withRules: rules!, andPlayer1: joueur1.player, andPlayer2: joueur2.player)
                gameToLaunch = GameViewModel(game: coreGame!,p1: joueur1,p2: joueur2)

            }
        }
    }

   
/*
#Preview {
    //let pers = PersistanceVM(games: [], players: [])
    let player1 = Player(withName: "test", andId: Owner.player1)!
    let player2 = Player(withName: "tata", andId: Owner.player2)!
    let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
    let coreGame = try! Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)

    let pers = PersistanceVM( players: [])
    
    let viewModel = GameViewModel(game: coreGame)
    
    
     return NewParty(gameToLaunch: viewModel,pers:pers)
    //permet de partager un objet ObservableObject à travers toute la hiérarchie des vues, sans avoir à le passer explicitement en paramètre à chaque vue
        .preferredColorScheme(.dark)
}

*/
