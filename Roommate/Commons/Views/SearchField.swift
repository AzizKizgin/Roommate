//
//  SearchField.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: text.isEmpty ? "magnifyingglass" : "multiply")
                .frame(width: 50)
                .foregroundStyle(.accent)
                .font(.title3)
                .onTapGesture {
                    if !text.isEmpty {
                        text = ""
                    }
                }
            TextField("", text: $text, prompt: Text("Search...").foregroundStyle(.gray))
                .padding(.vertical)
        }
        .background(.gray.opacity(0.4))
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    SearchField(text: .constant(""))
}
