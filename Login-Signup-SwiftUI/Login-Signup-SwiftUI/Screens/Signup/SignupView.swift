//
//  SignupView.swift
//  Login-Signup-SwiftUI
//
//  Created by Ankita Kotadiya on 21/11/24.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @EnvironmentObject private var router: Router<LoginFlow>
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Please fill all the information to register an account with us!")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            
            InputField(field: $name, placeHolder: "Fullname")
            InputField(field: $email, placeHolder: "Email")
            InputField(field: $password, isSecure: true, placeHolder: "Password")
            signupButton
            Spacer()
        }
        .navigationTitle("Signup")
        .padding()
        .alert("Error", isPresented: $showAlert, actions: {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Ok")
            })
        }, message: {
            Text(userViewModel.errorString ?? "Unknown Error")
        })
        
    }
    
    private var signupButton: some View {
        Button(action: {
            if userViewModel.validateNewUser(name, email: email, password: password) {
                router.dismiss(.popover)
            } else {
                showAlert = true
            }
        }, label: {
            Text("Signup")
        })
        .padding(.vertical, 20)
        .buttonStyle(CapsuleStyle())
    }
    
}

//#Preview {
//    SignupView()
//}
