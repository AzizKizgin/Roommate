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
    
    func updateUser(completion: @escaping (User?) -> Void) {
        isLoading = true
        guard validateFields() else {
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
    
    func setUser(user: UserProtocol) {
        userId = user.id
        updateInfo = UserUpdateInfo(from: user)
    }
    
    private func validateFields() -> Bool {
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
    
    private func setError(_ message: String){
        self.showError.toggle()
        self.errorText = message
    }
}
