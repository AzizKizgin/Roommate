//
//  EmptyListView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 22.04.2024.
//

import SwiftUI

struct EmptyListView: View {
    let title: LocalizedStringKey
    var body: some View {
        VStack {
            Image(systemName: "list.clipboard")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text(title)
                .font(.title)
        }
        .foregroundStyle(.accent)
    }
}

#Preview {
    EmptyListView(title: "No room here")
}
