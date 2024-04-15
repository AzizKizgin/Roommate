//
//  FormInput.swift
//  Roommate
//
//  Created by Aziz Kızgın on 15.04.2024.
//

import SwiftUI

struct FormInput: View {
    @AppStorage("isDark") private var isDark: Bool = false
    @State private var showContent: Bool = false
    @Binding var text: String
    let title: LocalizedStringKey
    let icon: String
    var isMultiline: Bool = false
    var isSecureText: Bool = false
    
    init(_ title: LocalizedStringKey, text: Binding<String>, icon: String) {
        self._text = text
        self.title = title
        self.icon = icon
    }
    var body: some View {
        HStack(alignment:isMultiline ? .top : .center){
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color.accentColor)
            if isMultiline {
                TextField(title, text: $text, axis: .vertical)
                    .lineLimit(5...10)
            }
            else if !isSecureText {
                TextField(title, text: $text)
            }
            else {
                HStack{
                    if showContent {
                        TextField(title, text: $text)
                    }
                    else {
                        SecureField(title, text: $text)
                    }
                    Image(systemName:showContent ? "eye.fill": "eye.slash.fill")
                        .foregroundStyle(.accent)
                        .onTapGesture {
                            showContent.toggle()
                        }
                }
            }
        }
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .frame(height: isMultiline ? nil : 25)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundStyle(.gray.opacity(isDark ? 0.25: 0.15))
        }
    }
}

extension FormInput {
    func secureText() ->  FormInput  {
        var copy = self
        copy.isSecureText = true
        return copy
    }
    func multiline() ->  FormInput  {
        var copy = self
        copy.isMultiline = true
        return copy
    }
}

#Preview {
    FormInput("Title",text: .constant("text"), icon: "house")
        .secureText()
}
