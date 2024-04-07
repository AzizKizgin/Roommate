//
//  LoginViewModel.swift
//  Roommate
//
//  Created by Aziz Kızgın on 7.04.2024.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var loginInfo: UserLoginInfo = UserLoginInfo(email: "", password: "")
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    @Published var isLoading: Bool = false
    
    private func validateFields() -> Bool {
        if loginInfo.email.isEmpty || loginInfo.password.isEmpty {
            setError("Please fill in all fields")
            return false
        }
        return true
    }
    
    private func setError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
    
    func login(completion: @escaping (User?) -> Void) {
        isLoading = true
        guard validateFields() else {
            isLoading = false
            return
        }
        UserManager.shared.login(loginData: loginInfo) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    self?.setError(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
}
