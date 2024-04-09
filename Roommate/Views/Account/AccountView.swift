//
//  AccountView.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    @StateObject private var accountVM = AccountViewModel()
    @Query private var users: [AppUser]
    @AppStorage("isDark") private var isDark: Bool = false
    @AppStorage("isNotificationAllow") private var isNotificationAllow: Bool = false
    var body: some View {
        List{
            Section("you"){
                NavigationLink {
                    UserSettingsView(accountVm: accountVM)
                } label: {
                    Label("Username", systemImage: "person.fill")
                }
                NavigationLink {
                    ChangePasswordView()
                } label: {
                    Label("Change Password", systemImage: "lock.circle.fill")
                }
            }
            Section("preferences"){
                Toggle(isOn: $isDark, label: {
                    Label("Dark Mode", systemImage: "moon.fill")
                })
                .tint(.accentColor)
                Toggle(isOn: $isNotificationAllow, label: {
                    Label("Notifications", systemImage: "bell.fill")
                })
                .tint(.accentColor)
            }
            Section("app"){
                Label("Version: 1.0.0", systemImage: "info.circle.fill")
                Link(destination: URL(string: "https://github.com/AzizKizgin")!, label: {
                    HStack{
                        Label("About Us", systemImage: "link.circle.fill")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                })
            }
            Section{
                Button(action: {}) {
                    HStack{
                        Label("Exit", systemImage: "figure.run.circle.fill")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                }
                .foregroundStyle(.red)
            }
        }
        .onAppear{
            DispatchQueue.main.async {
                if let appUser = users.first {
                    self.accountVM.setUser(user: appUser)
                }
    //            else {
    //                accountVm.errorText = "No user found"
    //                accountVm.showError.toggle()
    //            }
            }
        }
        .navigationTitle("Account")
        .foregroundStyle(.accent)
    }
}

#Preview {
    NavigationStack{
        AccountView()
    }
}
