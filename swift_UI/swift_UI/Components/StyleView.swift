//
//  BackgroundView.swift
//  swift_UI
//
//  Created by etudiant on 22/05/2025.
//

import SwiftUI

//Content peut être n’importe quelle vue SwiftUI (ex : Text, VStack, Image, Button, ou une vue personnalisée), mais ça doit impérativement être une vue.
struct StyleView<Content: View>: View {
    let content: () -> Content
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.bg, .bg2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                content().foregroundStyle(.main)
                    .font(.custom("Short Baby", size: 16, relativeTo: .body))
            }
        }
    }
}
