import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @EnvironmentObject private var router: Router<LoginFlow>
//    @EnvironmentObject private var mainRouter: Router<RouteFlow>
    
    @State private var email: String = ""
    @State private var password: String = ""
    @ScaledMetric private var verticalSpacing: CGFloat = 20
    @State private var rememberMe: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: verticalSpacing) {
//                Text("Hi, WelCome Back! 👋")
//                    .font(.title.bold())
                                
                // Email and Password Fields
                VStack(alignment: .leading, spacing: verticalSpacing) {
                    topFields(label: "Email", placeHolder: "Please Enter Email!", binding: $email)
                    topFields(label: "Password", placeHolder: "Please Enter Password", binding: $password, isSecure: true)
                }
                
                // Buttons
                rememberForgotPassbuttons
                
                // Login Button
                loginButton
                
                Spacer()
                
                dividerView
                
                Spacer()
                
                bottomView
            }
            .navigationTitle("Hi, WelCome Back! 👋")
            .padding()
            //            .onChange(of: userViewModel.errorString, perform: { value in
            //                showAlert = true
            //            })
            .onAppear(perform: {
                userViewModel.loadUser()
            })
            .alert("Error", isPresented: $showAlert) {
                Button(action: {
                    showAlert = false
                    userViewModel.errorString = nil
                }, label: {
                    Text("Ok")
                })
            } message: {
                Text(userViewModel.errorString ?? "Unknown Error")
            }
        }
    }
    
    @ViewBuilder
    private func topFields(label: String, placeHolder: String, binding: Binding<String>, isSecure: Bool = false) -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.body)
                .foregroundStyle(Color.gray)
            
            InputField(field: binding, isSecure: isSecure, placeHolder: placeHolder)
        }
    }
    
    private var rememberForgotPassbuttons: some View {
        HStack {
            Button(action: {
                rememberMe.toggle()
            }, label: {
                HStack(spacing: 8) {
                    RoundedRectangle(
                        cornerRadius: 5
                    )
                    .strokeBorder(.gray)
                    .overlay(content: {
                        rememberMe ? Image(systemName: "checkmark").tint(.black) : nil
                    })
                    .frame(width: 20, height: 20)
                    
                    Text("Remember Me")
                        .foregroundStyle(.black)
                }
            })
            
            Spacer()
            
            Button("Forgot password?") {
                router.navigate(to: .resetpass)
            }
            .foregroundStyle(Color.red)
        }
        .font(.body)
    }
    
    private var loginButton: some View {
        Button(action: {
            if userViewModel.validateLoginUser(email, password: password) {
                userViewModel.login()
            } else {
                showAlert = true
            }
        }, label: {
            Text("Login")
        })
        .buttonStyle(CapsuleStyle())
        .fontWeight(.semibold)
    }
    
    private var line: some View {
        VStack {
            Divider()
                .frame(height: 1)
                .foregroundStyle(Color.gray)
        }
    }
    
    private var dividerView: some View {
        HStack {
            line
            Text("OR")
                .font(.callout)
                .foregroundStyle(Color.gray)
                .padding()
            line
        }
        .padding()
    }
    
    private func socialMediaImage(_ lable: String, imageName: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
            Text(lable)
        }
    }
    
    private var facebookButton: some View {
        Button(action: {
            
        }, label: {
            socialMediaImage("Login with Facebook", imageName: "facebook")
        })
        .buttonStyle(CapsuleStyle())
    }
    
    private var googleButton: some View {
        Button(action: {
            
        }, label: {
            socialMediaImage("Login with Google", imageName: "google")
        })        .buttonStyle(
            CapsuleStyle(
                bgColor: .clear,
                textColor: .gray,
                hasBorder: true
            )
        )
    }
    
    private var signupButton: some View {
        Button(action: {
            router.navigate(to: .dummy, option: .sheet)
        }, label: {
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.black)
                
                Text("Signup")
                    .foregroundStyle(.blue)
            }
        })
    }
    
    private var bottomView: some View {
        VStack(alignment: .center, spacing: verticalSpacing) {
            facebookButton
            googleButton
            signupButton
        }
        .fontWeight(.semibold)
    }
}

//#Preview {
//    LoginView()
//}
