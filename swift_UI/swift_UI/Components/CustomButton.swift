//
//  Button.swift
//  swift_UI
//
//  Created by etudiant on 22/05/2025.
//

import SwiftUI

struct CustomButton<Destination: View>: View {
    @State private var naviguer:Bool = false
    let text: String
    let destination: () -> Destination
    let execute: (() -> Void)?
    
    //pour ne pas avoir a definir execute a chaque fois quand ce n'est pas necessaire on utilise une escaping closure
    init(
        text: String,
        execute: (() -> Void)? = nil,
        //une escaping closure est appelé quand la fonction a fini de s'éxecuté
        destination: @escaping () -> Destination
    ) {
        self.text = text
        self.execute = execute
        self.destination = destination
    }
    
    var body: some View {
        //Le ZStack est utilisé pour englober le tout pour retourner une seule vue
        ZStack{
            Button(action: {
                execute?()
                naviguer = true
            }) {
                Text(LocalizedStringKey(text))

                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            NavigationLink("", destination:destination(),isActive: $naviguer).hidden()
        }
    }
}
