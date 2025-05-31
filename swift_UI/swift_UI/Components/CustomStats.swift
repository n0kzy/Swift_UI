//
//  CustomStats.swift
//  swift_UI
//
//  Created by etudiant on 24/05/2025.
//

import SwiftUI

struct CustomStats: View {
    let titles : (String,String,String)
    let matches: [(String,String,String)]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(titles.0).bold().underline()
                Spacer()
                Text(titles.1).bold().underline()
                Spacer()
                Text(titles.2).bold().underline()
            }
            .padding(.horizontal)
            
            ForEach(matches, id: \.0) { match in
                HStack {
                    Text(match.0)
                    Spacer()
                    Text(match.1)
                    Spacer()
                    Text(match.2)
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
    }
}

