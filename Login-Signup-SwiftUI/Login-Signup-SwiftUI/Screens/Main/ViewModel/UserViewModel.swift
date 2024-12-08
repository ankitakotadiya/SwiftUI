import SwiftUI

final class UserViewModel: ObservableObject {
    @AppStorageCodable(key: "user") var storedUser: User?
    @AppStorageCodable(key: "login-user") var loginUser: User?
    @Published var user: User?
    var errorString: String?
    private let validationManager: Validating
    
    init(validationManager: Validating = ValidationManager()) {
        self.validationManager = validationManager
    }
    
    func saveUser(_ newUser: User) {
        storedUser = newUser
        user = newUser
    }
    
    func loadUser() {
        user = storedUser
    }
    
    func clearUser() {
        storedUser = nil
        loginUser = nil
        user = nil
    }
    
    func login() {
        loginUser = user
        user = loginUser
    }
    
    private func handlevalidation(_ validations: [ValidationError]) -> Bool {
        if let error = validations.first(where: {$0 != .success}) {
            errorString = error.rawValue
            return false
        } else {
            return true
        }
    }
    
    func validateLoginUser(_ email: String, password: String) -> Bool {
        let validations = [validationManager.validateEmail(email),
                           validationManager.validatePassword(password)
        ]
        
        guard handlevalidation(validations) else { return false }
        
        if user?.email.lowercased() == email.lowercased() && user?.password == password {
            return true
        } else {
            errorString = ValidationError.registration.rawValue
            return false
        }
    }
    
    func validateNewUser(_ name: String, email: String, password: String) -> Bool {
        let validations = [
            validationManager.validateFullName(name),
            validationManager.validateEmail(email),
            validationManager.validatePassword(password)
        ]
        
        guard handlevalidation(validations) else { return false }
        
        saveUser(User(name: name, email: email, password: password, isRemember: true))
        return true
    }
    
    func validatePasswordConfirmPassword(_ password: String, confirm: String) -> Bool {
        let validations = [
            validationManager.validatePassword(password),
            validationManager.validatePasswordandConfirmPassword(password, confirm: confirm)
        ]
        
        guard handlevalidation(validations) else { return false }
        
        guard let existingUser = user else {
            errorString = ValidationError.registration.rawValue
            return false
        }
        
        saveUser(User(name: existingUser.name, email: existingUser.email, password: password, isRemember: true))
        return true
    }
}
