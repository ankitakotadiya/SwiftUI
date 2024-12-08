import SwiftUI

struct ChatView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            
            // Approach 2
            VStack(alignment: .leading, content: {
                sectionHeader
                
                ScrollView(.vertical) {
                    ForEach(viewModel.users, id: \.self) { user in
                        RecentChatView(imageURL: user.imageURL, userName: user.firstName, aboutMe: user.aboutme)
                            .padding(.horizontal)
                    }
                }
            })
            
            // Approach 2
//            ScrollView(.vertical) {
//                LazyVStack(alignment:.leading, pinnedViews: [.sectionHeaders], content: {
//                    Section {
//                        ForEach(viewModel.users, id: \.self) { user in
//                            RecentChatView(imageURL: user.imageURL, userName: user.firstName, aboutMe: user.aboutme)
//                                .padding(.horizontal)
//                        }
//                    } header: {
//                        sectionHeader
//                    }
//                })
//            }
//            .clipped()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "magnifyingglass")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .onTapGesture {
                        dismiss()
                    }
            }
        })
        .navigationBarBackButtonHidden()
    }
    
    private func headerTitles(for first: String, second: String, isRightButton: Bool = false) -> some View {
        HStack(spacing: 5) {
            Text(first)
                .font(.headline)
                .foregroundStyle(.black)
            
            Text(second)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.Custom.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isRightButton {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.headline)
                    .foregroundStyle(Color.Custom.gray)
            }
        }
        .padding(.horizontal)
    }
    
    private var sectionHeader: some View {
        VStack(alignment: .leading , spacing: 5) {
            
            headerTitles(for: "Main Queue", second: "(\(viewModel.users.count))", isRightButton: false)
            
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(viewModel.users, id: \.self) { user in
                        ProfileImageView(imageURL: user.imageURL)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .scrollIndicators(.hidden)
            
            headerTitles(for: "Chats", second: "(Recent)", isRightButton: true)
                .padding(.bottom, 5)
        }
        .background(.white)
    }
}

//#Preview {
//    ChatView()
//}
