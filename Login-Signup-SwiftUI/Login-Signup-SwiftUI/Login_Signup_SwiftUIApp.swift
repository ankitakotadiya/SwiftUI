//
//  Login_Signup_SwiftUIApp.swift
//  Login-Signup-SwiftUI
//
//  Created by Ankita Kotadiya on 21/11/24.
//

import SwiftUI

@main
struct Login_Signup_SwiftUIApp: App {
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
//    @ObservedObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
//            NavigationStack(path: $router.navPath) {
//                ContentView()
//                    .navigationDestination(for: Router.AuthFlow.self) { destination in
//                        switch destination {
//                        case .login: LoginView()
//                        case .signup: SignupView()
//                        case .profile: ProfileView()
//                        case .forgotPassword: ForgotPasswordView()
//                        }
//                    }
//            }
//            .environmentObject(userViewModel)
//            .environmentObject(router)
        }
    }
}


