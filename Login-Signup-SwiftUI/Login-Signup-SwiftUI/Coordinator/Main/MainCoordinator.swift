import SwiftUI

enum LoginFlow: Route {
    case login
    case resetpass
    case signup
    case dummy
}

enum ProfileFlow: Route{
    case profile
}

enum RouteFlow: Route {
    case login(LoginFlow)
    case profile(ProfileFlow)
}


struct MainCoordinator: View {
    @StateObject var router: Router<RouteFlow> = Router<RouteFlow>(root: .login(.login))
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStackView(router: router) { (route: RouteFlow) in
            switch route {
            case .login(let loginRoute):
                LoginCoordinator(router: Router(root: loginRoute))
//                LoginCoordinator(router: router)
            case .profile(let profileRoute):
                ProfileCoordinator(router: Router(root: profileRoute))
            }
        }
        .environmentObject(userViewModel)
    }
}



//#Preview {
//    LoginCoordinator()
//}
