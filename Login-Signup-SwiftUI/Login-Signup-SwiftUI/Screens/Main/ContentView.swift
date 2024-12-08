//
//  ContentView.swift
//  Login-Signup-SwiftUI
//
//  Created by Ankita Kotadiya on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        Group {
            if userViewModel.loginUser == nil {
                MainCoordinator(router: Router(root: .login(.login)))
            } else {
                MainCoordinator(router: Router(root: .profile(.profile)))
            }
        }
        .environmentObject(userViewModel)
        
//        if userViewModel.loginUser == nil {
//            LoginView()
//                .navigationTitle("Login")
//        } else {
//            ProfileView()
//        }
    }
}

//#Preview {
//    ContentView()
//}
