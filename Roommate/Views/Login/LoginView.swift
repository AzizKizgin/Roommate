//
//  LoginView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 7.04.2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var loginVM = LoginViewModel()
    var body: some View {
        ScrollView{
            ZStack{
                Spacer().containerRelativeFrame([.horizontal, .vertical])
                VStack(spacing:15){
                    GreetingsView()
                    Spacer()
                    FormInput("Email", text: $loginVM.loginInfo.email, icon: "envelope.circle.fill")
                    FormInput("Password", text: $loginVM.loginInfo.password, icon: "lock.circle.fill")
                        .secureText()
                    FormButton(title: "Login", onPress: onPress, isLoading: loginVM.isLoading )
                    NavigationLink("Need Account?") {
                        RegisterView()
                    }
                    Spacer()
                }
                .padding()
                .alert(loginVM.errorText, isPresented: $loginVM.showError){
                    Button("Okay", role: .cancel) {}
                }
            }
        }
    }
}

extension LoginView {
    private func onPress() {
        loginVM.login { user in
            if let user {
                let currentUser = AppUser(from: user)
                modelContext.insert(currentUser)
                UserDefaults.standard.setValue(currentUser.token, forKey: "token")
            }
        }
    }
}

#Preview {
    NavigationStack{
        LoginView()
    }
}
