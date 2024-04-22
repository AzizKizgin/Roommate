//
//  RegisterView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var registerVM = RegisterViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView{
            VStack(spacing:15){
                FormInput("First Name", text: $registerVM.user.firstName, icon: "person.circle.fill")
                FormInput("Last Name", text: $registerVM.user.lastName, icon: "person.circle.fill")
                FormInput("Email", text: $registerVM.user.email, icon: "envelope.circle.fill")
                DateInput(dateText: $registerVM.user.birthDate)
                FormInput("Job", text: $registerVM.user.job, icon: "hammer.circle.fill")
                FormInput("Phone", text: $registerVM.user.phoneNumber, icon: "phone.circle.fill")
                FormInput("Password", text: $registerVM.user.password, icon: "lock.circle.fill")
                    .secureText()
                FormInput("Confirm Password", text: $registerVM.confirmPassword, icon: "lock.circle.fill")
                    .secureText()
                FormButton(title: "Register", onPress: {
                    Task {
                        await registerVM.registerUser()
                    }
                }, isLoading: registerVM.isLoading)
                    .padding(.vertical)
            }
            .padding()
            .alert(registerVM.errorText, isPresented: $registerVM.showError){
                Button("Okay", role: .cancel) {}
            }
            .alert("Your account has been created", isPresented: $registerVM.isSuccess){
                Button("Okay", role: .cancel) {
                    dismiss()
                }
            }
        }
        .navigationTitle("Register")
    }
}

#Preview {
    NavigationStack{
        RegisterView()
    }
}
