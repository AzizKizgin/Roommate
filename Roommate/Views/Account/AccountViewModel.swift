//
//  AccountViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 8.04.2024.
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var updateInfo: UserUpdateInfo = UserUpdateInfo()
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var isSuccess: Bool = false
    @Published var isLoading: Bool = false
    @Published var showLogoutAlert: Bool = false
    @Published var showNoUserAlert: Bool = false
    @Published var changePasswordInfo: ChangePasswordInfo = ChangePasswordInfo(oldPassword: "", newPassword: "")
    @Published var confirmPassword: String = ""
    
    // MARK: - request functions
    func updateUser(completion: @escaping (User?) -> Void) {
        isLoading = true
        guard validateUpdateUserFields() else {
            isLoading = false
            return
        }
        UserManager.shared.updateUser(id: userId, userInfo: updateInfo) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    completion(user)
                case .failure(let error):
                    completion(nil)
                    self?.setError(error.localizedDescription)
                }
            }
        }
    }
    
    func updatePassword() {
        isLoading = true
        guard validateChangePasswordFields() else {
            isLoading = false
            return
        }
        UserManager.shared.changePassword(changePasswordInfo: changePasswordInfo) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isSuccess.toggle()
                case .failure(let error):
                    self?.setError(error.localizedDescription)
                }
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void){
        isLoading = true
        UserManager.shared.logout { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.isSuccess.toggle()
                    if data {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                case .failure(let error):
                    self?.setError(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    // MARK: - Setting user
    func setUser(user: UserProtocol) {
        userId = user.id
        updateInfo = UserUpdateInfo(from: user)
    }
    
    // MARK: - Validate functions
    private func validateUpdateUserFields() -> Bool {
        if updateInfo.firstName.isEmpty ||
            updateInfo.lastName.isEmpty ||
            updateInfo.about.isEmpty ||
            updateInfo.birthDate.isEmpty ||
            updateInfo.job.isEmpty ||
            updateInfo.phoneNumber.isEmpty
        {
            setError("Please fill in all fields")
            return false
        }
        return true
    }
    
    private func validateChangePasswordFields() -> Bool {
        if changePasswordInfo.newPassword.isEmpty || changePasswordInfo.oldPassword.isEmpty
        {
            setError("Please fill in all fields")
            return false
        }
        else if confirmPassword != changePasswordInfo.newPassword {
            setError("Passwords do not match")
            return false
        }
        else if !Utils.isPasswordValid(for: changePasswordInfo.newPassword){
            setError("The password must contain at least 8 characters, 1 special character and 1 uppercase letter.")
            return false
        }
        return true
    }
    
    func setError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
}
