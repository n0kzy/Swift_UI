import SwiftUI
import Connect4Core
import Connect4Persistance

let resultSections: [(title: String, filter: (GameResult) -> Bool)] = [
    ("en cours", { $0.winner == Owner.noOne }),
    ("terminées", { $0.winner != Owner.noOne })
]

struct Historique: View {
    @State private var g: Game? = nil
    var body: some View {
        StyleView{
        ScrollView{
            Text("Parties Enregistrées").font(Font.custom("Short Baby", size: 32))
            //mettre en lazyGrid
                VStack {
                    
                    ForEach(resultSections, id: \.title) { section in
                                        Text(section.title)
                                            .font(Font.custom("Short Baby", size: 24))
                                            .padding()


                        
                        ForEach(PersistanceVM.shared.results.filter(section.filter), id: \.date) { result in
                            
                            HStack {
                                CustomStats(
                                    titles: ("Date", "Joueurs", "Règles"),
                                    matches: [(
                                        DateFormatter.localizedString(
                                            from: result.date,
                                            dateStyle: .short,
                                            timeStyle: .none
                                        ),
                                        result.players.map { $0.name }.joined(separator: " vs "),
                                        result.rules.type
                                    )]
                                )
                                .padding()

                                /*
                                if section.title == "terminées" {
                                    if let safeGame = g {
                                        CustomButton(
                                            text: "Continue",
                                            execute: {
                                                loadGame()
                                            },
                                            destination: {
                                                partyScreen(
                                                    selectedItem: safeGame.editableData.type,
                                                    avatarImage: Image("image_profile"),
                                                    avatarImage2: Image("image_profile"),
                                                    game: safeGame,
                                                    pers: persistanceVM
                                                )
                                            }
                                        )
                                    }
                                } */
                            }
                        }
                        }
                    }
        } .task {
                    await PersistanceVM.shared.loadResults()
                }
            }
        }
    func loadGame() {
        Task {
            do {
                g = try await Game(fromSavedGame: "game", inFolder: "game")
            } catch {
                print("Erreur lors du chargement de la partie : \(error)")
            }
        }
    }

}

#Preview {
        let player1 = Player(withName: "toto", andId: Owner.player1)!
        let player2 = Player(withName: "tata", andId: Owner.player2)!
        let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
        let coreGame = try! Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)

        //let gamesVM = GamesVM(with: [coreGame]
        //let results = [GameResult] = []
        
    return Historique()
            .preferredColorScheme(.dark)
}

