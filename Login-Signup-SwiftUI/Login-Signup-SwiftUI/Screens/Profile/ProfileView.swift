import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: UserViewModel
    @EnvironmentObject private var router: Router<LoginFlow>
//    @EnvironmentObject private var mainrouter: Router<RouteFlow>
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 10) {
                    Text(viewModel.user?.initials ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 70, height: 70)
                        .background(
                            Circle()
                                .fill(.gray)
                        )
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.user?.name ?? "")
                            .font(.headline)
                            .foregroundStyle(.blue)
                        
                        Text(viewModel.user?.email ?? "")
                            .font(.headline)
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            Section {
                
                signoutButton
                deleteAcountButton
                
            }
        }
        .onAppear(perform: {
            viewModel.loadUser()
        })
        .navigationTitle("Profile")
        .navigationBarBackButtonHidden(true)
    }
    
    
    private var signoutButton: some View {
        Button(action: {
            viewModel.clearUser()
//            router.navigateToroot()
            
        },
               label: {
            Label(
                title: {
                    Text("Sign Out")
                        .font(.body)
                        .foregroundStyle(.black)
                },
                icon: {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundStyle(.red)
                }
            )
        })
    }
    
    private var deleteAcountButton: some View {
        Button(action: {
            viewModel.clearUser()
//            router.navigateToroot()

        },
               label: {
            Label(
                title: {
                    Text("Delete Account")
                        .font(.body)
                        .foregroundStyle(.black)
                },
                icon: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
            )
        })
    }
}

//#Preview {
//    ProfileView()
//}
