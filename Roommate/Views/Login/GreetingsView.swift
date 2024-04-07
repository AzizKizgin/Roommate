//
//  GreetingsView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 7.04.2024.
//

import SwiftUI

struct GreetingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing:15){
            Text(Utils.checkIsNight() ? "Good Evening": "Have a Nice Day")
                .font(.largeTitle)
                .bold()
            VStack(spacing:8){
                Text("Welcome Back")
                    .font(.title2)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text("Sign in to continue")
                    .font(.callout)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    GreetingsView()
}
