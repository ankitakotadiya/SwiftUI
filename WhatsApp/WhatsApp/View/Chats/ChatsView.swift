import SwiftUI

struct ChatsView: View {
    @EnvironmentObject private var vm: ChatViewModel
    @State private var selectedTitle: String = "All"
    private let dividerLeading: Double = 100
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    HeaderCell(selectedTitle: $selectedTitle)
                    
                    archivedCell
                    DividerView(leading: dividerLeading)
                    
                    ForEach(vm.users) { user in
                        rowView(user: user)
                        DividerView(leading: dividerLeading)
                    }
                }
                .navigationTitle("WA Business")
                .searchable(text: $vm.searchText, placement: .navigationBarDrawer)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {}, label: {
                            Text("Edit")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "square.and.pencil")
                        })
                    }
                }
            }
        }
    }
    
    private func rowView(user: User) -> some View {
        HStack(spacing: 20) {
            
            ProfileImageView(imageURL: user.imageURL)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(user.firstName + " " + user.lastName)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(user.date)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                
                Text(user.message)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.horizontal)
    }
    
    private var archivedCell: some View {
        
        HStack(spacing: 20) {
            Image(systemName: "trash")
                .frame(width: 80, height: 40)
                .foregroundStyle(.gray)
            
            Button("Archived") {
                // Perform Action
            }
            .font(.headline)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading)
    }
    
}

