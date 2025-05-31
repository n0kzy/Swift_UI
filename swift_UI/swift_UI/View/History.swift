import SwiftUI
import Connect4Core


let sections = [("en cours", 1), ("terminées", 0)]

struct Historique: View {
    @ObservedObject var data : GamesVM
    var body: some View {
        StyleView{
        ScrollView{
            Text("Parties Enregistrées").font(Font.custom("Short Baby", size: 32))
                VStack {
                    ForEach(sections, id: \.0) { section in
                        ForEach(data.games) { gameVM in
                            CustomStats(
                                titles: ("Date", "Joueurs", "Règles"),
                                matches: [(
                                    DateFormatter.localizedString(
                                        from: Date(),
                                        dateStyle: .short,
                                        timeStyle: .none
                                    ),
                                    gameVM.name,
                                    gameVM.type
                                )]
                            )
                            .padding()
                        }
                    }

                    }
                }
            }
        }
}

#Preview {
    do {
        let player1 = Player(withName: "toto", andId: Owner.player1)!
        let player2 = Player(withName: "tata", andId: Owner.player2)!
        let rules = Connect4Rules(nbRows: 6, nbColumns: 7, nbPiecesToAlign: 4)!
        let coreGame = try! Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)

        let gamesVM = GamesVM(with: [coreGame])
        
        return Historique(data: gamesVM)
            .preferredColorScheme(.dark)
    } catch {
        return Text("Erreur dans le preview : \(error.localizedDescription)")
    }
}

