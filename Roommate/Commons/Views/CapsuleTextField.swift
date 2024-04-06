//
//  CapsuleTextField.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

import Foundation
import SwiftUI

struct CapsuleTextField: ViewModifier {
    let icon: String
    @AppStorage("isDark") private var isDark: Bool = false
    func body(content: Content) -> some View {
        HStack(alignment:.top){
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color.accentColor)
            content
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundStyle(.gray.opacity(isDark ? 0.25: 0.15))
        }
    }
}

extension View {
    func capsuleTextField(icon: String) -> some View {
        self.modifier(CapsuleTextField(icon: icon))
    }
}

#Preview {
    TextField("Text", text: .constant(""))
        .capsuleTextField(icon: "checkmark.circle.fill")
}
