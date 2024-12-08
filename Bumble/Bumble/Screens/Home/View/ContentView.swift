import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var options: [String] = ["Everyone", "Trending"]
    @AppStorage("home_filter") private var selectedFilter: String = "Everyone"
    @State private var showChat: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 10) {
                    // Filter
                    HomeFilterView(filters: options, selectedFilter: $selectedFilter)
                        .background(alignment: .bottom) {
                            Divider()
                        }
                    
                    // Swipe Sections
                    ZStack {
                        if let user = viewModel.users.last {
                            CardView(user: user)
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                }
                .padding()
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Image(systemName: "line.horizontal.3")
                        .onTapGesture {
                            showChat = true
                        }
                    Image(systemName: "arrow.uturn.left")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "slider.horizontal.3")
                }
                
                ToolbarItem(placement: .principal) {
                    Text("bumble")
                        .font(.title)
                        .foregroundStyle(Color.Custom.yellow)
                }
            })
            .font(.title3)
            .fontWeight(.medium)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.getData()
            }
            .navigationDestination(isPresented: $showChat) {
                ChatView()
                    .environmentObject(viewModel)
            }
        }
        .tint(Color.Custom.black)
    }
    
}

//#Preview {
//    ContentView()
//}
