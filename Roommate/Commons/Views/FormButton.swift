//
//  FormButton.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

import SwiftUI
struct FormButton: View {
    let title: LocalizedStringKey
    let onPress: () -> Void
    var isLoading: Bool = false
    var body: some View {
        Button(action: onPress, label: {
            Group{
                if isLoading{
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.4, anchor: .center)
                }
                else{
                    Text(title)
                        .font(.title3)
                }
            }
            .disabled(isLoading)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
        })
        .buttonStyle(.borderedProminent)
        
    }
}

#Preview {
    FormButton(title: "Login", onPress: {})
}
