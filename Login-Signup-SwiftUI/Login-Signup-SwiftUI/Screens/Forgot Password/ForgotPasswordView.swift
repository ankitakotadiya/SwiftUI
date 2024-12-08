import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject private var viewModel: UserViewModel
    @EnvironmentObject private var router: Router<LoginFlow>
    
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            InputField(field: $password, isSecure: true, placeHolder: "Password")
            InputField(field: $confirm, isSecure: true, placeHolder: "Confirm Password")
            resetPassword
            Spacer()
        }
        .navigationTitle("Reset Password")
        .padding()
        .alert("Error", isPresented: $showAlert, actions: {
            Button(action: {
            }, label: {
                Text("Ok")
            })
            
            Button(action: {
                router.dismiss(.push)
            }, label: {
                Text("Login")
            })
            
        }, message: {
            Text(viewModel.errorString ?? "Unknown Error.")
        })
        
    }
    
    private var resetPassword: some View {
        Button(action: {
            if viewModel.validatePasswordConfirmPassword(password, confirm: confirm) {
                router.dismiss(.push)
            } else {
                showAlert = true
            }
        }, label: {
            Text("Reset Password")
        })
        .buttonStyle(CapsuleStyle())
    }
    
    
}

//#Preview {
//    ForgotPasswordView()
//}
