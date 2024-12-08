import SwiftUI

struct ProfileCoordinator: View {
    @StateObject var router: Router<ProfileFlow>
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStackView(router: router) { (route: ProfileFlow) in
            switch route {
                
            case .profile: ProfileView()
            }
        }
        .environmentObject(userViewModel)
        .environmentObject(router)
    }
}


//#Preview {
//    ProfileCoordinator()
//}
