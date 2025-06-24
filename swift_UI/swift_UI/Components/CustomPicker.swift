//
//  CustomPicker.swift
//  swift_UI
//
//  Created by etudiant on 24/05/2025.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var selectedItem : String
    let options : [String]
    let text : String
    var image : Image?
    
    var body: some View {
        HStack{
            Text(LocalizedStringKey(text))
            Picker(LocalizedStringKey("choix"), selection: $selectedItem){
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }
           /* .onChange(of: selectedItem) {
                _ in
                image = selectedItem == "IA" ? image("image_ia") : image("image_profile")
            }
            */
        }
    }
}

