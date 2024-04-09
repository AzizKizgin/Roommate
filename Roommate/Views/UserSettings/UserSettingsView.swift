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
    @State private var isLoading: Bool = true
    @Query private var users: [AppUser]
    @ObservedObject var accountVm: AccountViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 15){
                UserPhotoPicker(image: $accountVm.updateInfo.profilePicture,isImageLoading: isLoading)
                TextField("FirstName", text: $accountVm.updateInfo.firstName)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("LastName", text: $accountVm.updateInfo.lastName)
                    .capsuleTextField(icon: "person.circle.fill")
                TextField("Job", text: $accountVm.updateInfo.job)
                    .capsuleTextField(icon: "hammer.circle.fill")
                TextField("Phone", text: $accountVm.updateInfo.phoneNumber)
                    .capsuleTextField(icon: "phone.circle.fill")
                DateInput(dateText: $accountVm.updateInfo.birthDate)
                TextField("About", text: $accountVm.updateInfo.about, axis: .vertical)
                    .lineLimit(5...10)
                    .capsuleTextField(icon: "info.circle.fill")
                FormButton(title: "Save", onPress: updateUser)
            }
            .padding()
            .alert(accountVm.errorText, isPresented: $accountVm.showError){
                Button("Okay", role: .cancel) {}
            }
            .alert("Your info updated", isPresented: $accountVm.isSuccess){
                Button("Okay", role: .cancel) {dismiss()}
            }
        }
        .onAppear{
            DispatchQueue.main.async {
                if let appUser = users.first {
                    self.accountVm.setUser(user: appUser)
                }
    //            else {
    //                accountVm.errorText = "No user found"
    //                accountVm.showError.toggle()
    //            }
                self.isLoading = false
            }
        }
    }
}

extension UserSettingsView {
    private func updateUser(){
        accountVm.updateUser { user in
            if let user, let appUser = users.first {
                appUser.update(from: user)
                try? context.save()
                accountVm.isSuccess.toggle()
            }
        }
    }
}

#Preview {
    UserSettingsView(accountVm: AccountViewModel())
}
