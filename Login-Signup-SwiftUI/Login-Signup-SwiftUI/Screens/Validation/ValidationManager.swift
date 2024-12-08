import Foundation


enum ValidationError: String {
    case emptyEmail = "Please enter an Email."
    case emptyPassword = "Please enter Password."
    case invalidEmail = "Please enter valid Email."
    case invalidPassword = "Please enter valid Password."
    case weak = "Please enter at least 6 characters long Password."
    case success = "Login Success."
    case emptyFullName = "Please enter FullName."
    case registration = "Your account is not registered with us! Please signup."
    case confirmPassword = "Password and Confirm password must be same."
    case tryLater = "Please try again later."
}

protocol Validating {
    func validateEmail(_ email: String?) -> ValidationError
    func validatePassword(_ password: String?) -> ValidationError
    func validateFullName(_ name: String?) -> ValidationError
    func validatePasswordandConfirmPassword(_ password: String?, confirm: String?) -> ValidationError
}

final class ValidationManager: Validating {
    
    func validateEmail(_ email: String?) -> ValidationError {
        guard let email = email, !email.isEmpty else {
            return .emptyEmail
        }
        
        if !isEmailValid(email) {
            return .invalidEmail
        }
        return .success
    }
    
    func validatePassword(_ password: String?) -> ValidationError {
        guard let password = password, !password.isEmpty else {
            return .emptyPassword
        }
        
        if password.count < 6 {
            return .weak
        }
        
        if !isPasswordValid(password) {
            return .invalidPassword
        }
        
        return .success
    }
    
    func validateFullName(_ name: String?) -> ValidationError {
        guard let name = name, !name.isEmpty else {
            return .emptyFullName
        }
        return .success
    }
    
    func validatePasswordandConfirmPassword(_ password: String?, confirm: String?) -> ValidationError {
        guard let password = password, let confirm = confirm, !password.isEmpty else {
            return .emptyPassword
        }
        
        if password != confirm {
            return .confirmPassword
        }
        
        if !isPasswordValid(password) {
            return .invalidPassword
        }
        
        return .success
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$&*]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
