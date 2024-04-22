//
//  UserSettingsView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 9.04.2024.
//

import SwiftUI
import SwiftData

struct UserSettingsView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var users: [AppUser]
    @ObservedObject var accountVm: AccountViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 15){
                UserPhotoPicker(image: $accountVm.updateInfo.profilePicture)
                FormInput("FirstName", text: $accountVm.updateInfo.firstName, icon: "person.circle.fill")
                FormInput("LastName", text: $accountVm.updateInfo.lastName, icon: "person.circle.fill")
                FormInput("Job", text: $accountVm.updateInfo.job, icon: "hammer.circle.fill")
                FormInput("Phone", text: $accountVm.updateInfo.phoneNumber, icon: "phone.circle.fill")
                DateInput(dateText: $accountVm.updateInfo.birthDate)
                FormInput("About", text: $accountVm.updateInfo.about, icon: "info.circle.fill")
                    .multiline()
                FormButton(title: "Save", onPress: updateUser,isLoading: accountVm.isLoading)
            }
            .padding()
            .alert(accountVm.errorText, isPresented: $accountVm.showError){
                Button("Okay", role: .cancel) {}
            }
            .alert("Your info updated", isPresented: $accountVm.isSuccess){
                Button("Okay", role: .cancel) {dismiss()}
            }
        }
    }
}

extension UserSettingsView {
    private func updateUser(){
        Task {
            await accountVm.updateUser { user in
                if let user, let appUser = users.first {
                    appUser.update(from: user)
                    try? context.save()
                    accountVm.isSuccess.toggle()
                }
            }
        }
    }
}

#Preview {
    UserSettingsView(accountVm: AccountViewModel())
}
