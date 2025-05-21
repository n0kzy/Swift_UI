import SwiftUI

let data1 = [
    ("20/01/2024", "didier vs bertrant", "Classiques"),
    ("20/01/2024", "louis vs bertrant", "Classiques"),
    ("20/01/2024", "didier vs louis", "Classiques"),
    ("20/01/2024", "didier vs bertrant", "Classiques"),
    ("20/01/2024", "louis vs bertrant", "Classiques"),
    ("20/01/2024", "didier vs louis", "Classiques"),
    ("20/01/2024", "didier vs bertrant", "Classiques"),
    ("20/01/2024", "louis vs bertrant", "Classiques"),
    ("20/01/2024", "didier vs louis", "Classiques"),
    ("20/01/2024", "didier vs bertrant", "Classiques"),
    ("20/01/2024", "louis vs bertrant", "Classiques"),

]

let sections = [("en cours", 1), ("terminées", 0)]

struct Historique: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.bg, .bg2]),
                           startPoint: .top,
                           endPoint: .bottom).ignoresSafeArea()
        ScrollView{
            Text("Parties Enregistrées")
                .font(Font.custom("Short Baby", size: 32))
                .padding()
            
                .ignoresSafeArea()
                VStack {
                    ForEach(sections, id: \.0) { section in
                        VStack() {
                            Text(section.0)
                                .font(.headline)
                                .padding(.top,40)
                            HStack {
                                Text("Date").underline().padding()
                                Text("Joueurs").underline().padding()
                                Text("Règles").underline().padding()
                            }.padding()
                            ForEach(data1, id: \.1) { item in
                                    HStack {
                                        Text(item.0)
                                        Text(item.1)
                                        Text(item.2)
                                    }
                            }
                        }
                    }
                }
            }
        }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))

    }
}

#Preview {
    Historique()
        .preferredColorScheme(.dark) // ou .light

}

