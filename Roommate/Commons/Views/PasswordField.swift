//
//  PasswordField.swift
//  Roommate
//
//  Created by Aziz Kızgın on 7.04.2024.
//

import SwiftUI

struct PasswordField: View {
    let titleKey: String
    @Binding var text: String
    @State private var showContent: Bool = false
    
    init(_ titleKey: String, text: Binding<String>) {
        self.titleKey = titleKey
        self._text = text
    }
    var body: some View {
        HStack{
            Group {
                if showContent {
                    TextField(titleKey, text: $text)
                }
                else {
                    SecureField(titleKey, text: $text)
                }
            }
            Image(systemName:showContent ? "eye.fill": "eye.slash.fill")
                .foregroundStyle(.accent)
                .onTapGesture {
                    showContent.toggle()
                }
        }
        .capsuleTextField(icon: "lock.circle.fill")
    }
}

#Preview {
    PasswordField("Password", text: .constant("Password"))
}
