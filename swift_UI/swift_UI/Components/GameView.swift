    //
    //  GameView.swift
    //  swift_UI
    //
    //  Created by etudiant on 24/05/2025.
    //

    import SwiftUI
    import Connect4Core
    struct GameView: View {
        @ObservedObject var game: GameViewModel

        let rows:Int = 7
        let columns:Int = 6
        var body: some View {
            HStack{
                PlayerView(image:Image(systemName: "person.crop.circle"), playerName: "CodeLord", playerType: "Humain")
                PlayerView(image:Image(systemName:"brain.head.profile"), playerName: "Neptune", playerType: "IA")
            }
            TextField("Game Name", text: $game.editableData.name).multilineTextAlignment(.center)
            Text("Score : \(game.editableData.score)")
            Button(action: {
                game.startEditing()
                }) {
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(.blue)
            }
            VStack(spacing: 5) {
                ForEach(0..<game.game.board.nbRows , id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(0..<game.game.board.nbColumns , id: \.self) { col in
                            //let piece = $game.game.game.board // Pré-calcul ici
                            Button(action: {

                            }) {
                           //CellView(piece:piece)
                                }

                        }
                    }
                }
            }
            .padding(10)
            .background(Color.blue)
            .cornerRadius(12)
        }
    }
/*
#Preview {
    do {
        guard
            let rules = Connect4Rules(nbRows: 4, nbColumns: 4, nbPiecesToAlign: 4),
            let player1 = Player(withName: "CodeLord", andId: .player1),
            let player2 = Player(withName: "Neptune", andId: .player2)
        else {
            return Text("Échec de création des règles ou des joueurs")
        }

        let gameCore = Connect4Core.Game(withRules: rules, andPlayer1: player1, andPlayer2: player2)
        let viewModel = GameViewModel(game: gameCore!)
        return GameView(game: viewModel)
    } catch {
        return Text("Erreur de création du jeu : \(error.localizedDescription)")
    }
}

*/
