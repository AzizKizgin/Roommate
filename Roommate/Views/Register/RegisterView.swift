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
                TextField("First Name", text: $registerVM.user.firstName)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("Last Name", text: $registerVM.user.lastName)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("Email", text: $registerVM.user.email)
                    .capsuleTextField(icon: "person.circle.fill")
                DateInput(date: $registerVM.user.birthDate)
                TextField("Job", text: $registerVM.user.job)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("Phone", text: $registerVM.user.phoneNumber)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("Password", text: $registerVM.user.password)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("Confirm Password", text: $registerVM.confirmPassword)
                    .capsuleTextField(icon: "person.circle.fill")
                FormButton(title: "Register", onPress: registerVM.registerUser)
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
