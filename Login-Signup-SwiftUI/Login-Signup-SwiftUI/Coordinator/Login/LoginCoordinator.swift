import SwiftUI

struct LoginCoordinator: View {
    @ObservedObject var router: Router<LoginFlow>
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStackView(router: router) { (route: LoginFlow) in
            Group {
                switch route {
                case .login: LoginView()
                case .signup: SignupView()
                case .resetpass: ForgotPasswordView()
                case .dummy: DummyView()
                }
            }
            .environmentObject(userViewModel)
            .environmentObject(router)
        }
    }
}
//#Preview {
//    LoginCoordinator()
//}
