//
//  NavBarView.swift
//  swift_UI
//
//  Created by etudiant on 21/05/2025.
//

import SwiftUI

struct NavBarView: View {
    
    //@Binding var showNavBar:Bool
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomeView()) {
                        Label("Courses", systemImage: "book")
                }
                Label("Tutorials", systemImage: "square")
            }
            .navigationTitle("Learn")
            

            HomeView()

        }
    }
}

#Preview {
    NavBarView()
}
