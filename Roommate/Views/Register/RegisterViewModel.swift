//
//  RegisterViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var user: UserRegisterInfo = UserRegisterInfo()
    @Published var confirmPassword: String = ""
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    // MARK: - Register
    func registerUser() {
        isLoading = true
        guard validateFields() else {
            isLoading = false
            return
        }
        UserManager.shared.register(registerData: user) { [weak self] result in
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
                    self?.handleAuthError(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Set error
    private func setFieldError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
    
    private func handleAuthError(_ error: String){
        showError.toggle()
        errorText = error
    }
    
    // MARK: - Field Validation
    private func validateFields() -> Bool{
        if user.firstName.isEmpty 
            || user.lastName.isEmpty
            || user.email.isEmpty
            || user.password.isEmpty 
            || user.job.isEmpty
            || user.phoneNumber.isEmpty
            || confirmPassword.isEmpty {
            setFieldError("Please fill in all fields")
            return false
        }
        else if !Utils.isValidEmail(for: user.email) {
            setFieldError("Your email is invalid")
            return false
        }
        else if !Utils.isPasswordValid(for: user.password){
            setFieldError("The password must contain at least 8 characters, 1 special character and 1 uppercase letter.")
            return false
        }
        else if user.password != confirmPassword {
            setFieldError("Passwords do not match")
            return false
        }
        return true
    }
}
