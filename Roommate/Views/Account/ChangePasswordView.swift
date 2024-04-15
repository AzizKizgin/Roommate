//
//  ChangePasswordView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 9.04.2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var accountVM: AccountViewModel
    var body: some View {
        ScrollView{
            ZStack{
                Spacer().containerRelativeFrame([.horizontal, .vertical])
                VStack(spacing: 15) {
                    FormInput("Old Password", text: $accountVM.changePasswordInfo.oldPassword, icon: "lock.circle.fill")
                        .secureText()
                    FormInput("New Password", text: $accountVM.changePasswordInfo.newPassword, icon: "lock.circle.fill")
                        .secureText()
                    FormInput("Confirm New Password", text: $accountVM.confirmPassword, icon: "lock.circle.fill")
                        .secureText()
                    FormButton(title: "Change Password", onPress: accountVM.updatePassword, isLoading: accountVM.isLoading)
                }
                .padding()
                Spacer()
            }
        }
        .navigationTitle("Change Password")
        .alert(accountVM.errorText, isPresented: $accountVM.showError){
            Button("Okay", role: .cancel) {}
        }
        .alert("Your password updated", isPresented: $accountVM.isSuccess){
            Button("Okay", role: .cancel) {dismiss()}
        }
    }
}

#Preview {
    ChangePasswordView(accountVM: AccountViewModel())
}
