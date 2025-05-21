//
//  NewParty.swift
//  swift_UI
//
//  Created by etudiant on 14/05/2025.
//

import SwiftUI
import PhotosUI


struct NewParty: View {
    @State private var selectedItem = "Classique"
    @State private var lignes = 6
    @State private var jetons = 4
    @State private var colonnes = 7
    @State private var secondesInput: String = "0"
    @State private var minutesInput: String = "1"
    @State private var timer: Timer? = nil
    @State private var imageSelection: PhotosPickerItem? = nil
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image? = Image("connect")
    @State private var avatarItem2: PhotosPickerItem?
    @State private var avatarImage2: Image? = Image("connect")
    @State private var naviguer:Bool = false
    // Liste des options
    let options = ["Classique", "Option 2", "Option 3", "Option 4"]
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.bg, .bg2]),
                               startPoint: .top,
                               endPoint: .bottom).ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("NOUVELLE PARTIE").font(Font.custom("Short Baby",size:32)).padding()
                        
                        HStack {
                            VStack {
                                Text("JOUEUR 1")
                                Text("toto1")
                                
                                avatarImage?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Rectangle())
                                    .onChange(of: avatarItem) {
                                        Task {
                                            if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                                                avatarImage = loaded
                                            } else {
                                                print("Failed")
                                            }
                                        }
                                    }
                                PhotosPicker("modifier", selection: $avatarItem, matching: .images)
                                
                            }
                            Spacer()
                            VStack {
                                Text("JOUEUR 2")
                                Text("toto2")
                                
                                avatarImage2?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Rectangle())
                                    .onChange(of: avatarItem2) {
                                        Task {
                                            if let loaded = try? await avatarItem2?.loadTransferable(type: Image.self) {
                                                avatarImage2 = loaded
                                            } else {
                                                print("Failed")
                                            }
                                        }
                                    }
                                PhotosPicker("modifier", selection: $avatarItem2, matching: .images)
                                
                            }
                        }
                        
                    }.frame(maxWidth:.infinity).padding(.horizontal,50)
                    Divider()
                    HStack {
                        Text("Règles du jeu")
                        Picker("Choisissez une option", selection: $selectedItem) {
                            // Créer une option pour chaque élément de la liste
                            ForEach(options, id: \.self) { option in
                                Text(option)
                            }
                        }
                    }
                    Grid(alignment: .leading, horizontalSpacing: 15, verticalSpacing: 10) {
                        
                        GridRow {
                            Text("Dimensions :")
                                .gridCellAnchor(.topLeading)
                            // cellule vide pour l'alignement
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
                    Button(action: {
                        naviguer = true
                    }) {
                        Text("JOUER")
                            .padding()
                            .foregroundColor(.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.main, lineWidth: 2)
                            )
                    }
                    NavigationLink("", destination: partyScreen(),isActive: $naviguer).hidden()
                }.frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .top)
            }.foregroundStyle(.main).font(.custom("Short Baby", size: 16, relativeTo: .body))
        }}
}
#Preview {
    NewParty()
}
