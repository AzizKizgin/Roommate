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
    @Environment(\.modelContext) private var context
    @AppStorage("isDark") private var isDark: Bool = false
    @AppStorage("isNotificationAllow") private var isNotificationAllow: Bool = false
    var body: some View {
        List{
            Section("you"){
                NavigationLink {
                    UserSettingsView(accountVm: accountVM)
                } label: {
                    Label("User Info", systemImage: "person.fill")
                }
                NavigationLink {
                    ChangePasswordView(accountVM: accountVM)
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
                Button(action:{ accountVM.showLogoutAlert.toggle()}) {
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
        .alert("Do you want to logout?", isPresented: $accountVM.showLogoutAlert){
            Button("Yes", role: .destructive) {
                accountVM.logout { isLogout in
                    if isLogout {
                        try? context.delete(model: AppUser.self)
                        try? context.delete(model: SavedRoom.self)
                    }
                }
            }
            Button("No", role: .cancel) {}
        }
        .alert("No user found", isPresented: $accountVM.showNoUserAlert){
            Button("Okay", role: .cancel) {
                try? context.delete(model: AppUser.self)
            }
        }
        .onAppear{
            DispatchQueue.main.async {
                if let appUser = users.first {
                    self.accountVM.setUser(user: appUser)
                }
    //            else {
    //                accountVm.showNoUserAlert.toggle()
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
