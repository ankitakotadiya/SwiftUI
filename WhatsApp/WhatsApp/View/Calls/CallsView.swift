import SwiftUI

struct CallsView: View {
    @EnvironmentObject private var vm: ChatViewModel
    private let dividerLeading: Double = 100
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    SectionHeaderView(action: {
                        // Perform Action
                    }, title: "Favourites")
                    
                    HStack {
                        HStack(spacing: 20) {
                            Button(action: {}, label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.blue)
                                    .padding(10)
                                    .background {
                                        Circle().fill(Color(uiColor: UIColor.systemGray6))
                                    }
                            })
                            
                            Button(action: {}, label: {
                                Text("Add Favourites")
                            })
                            
                        }
                        .font(.title3)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    SectionHeaderView(action: {
                        // Perform
                    }, title: "Recent")
                    
                    LazyVStack(alignment: .leading) {
                        
                        ForEach(vm.users) { user in
                            HStack {
                                ProfileImageView(imageURL: user.imageURL)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                        Text(user.firstName + " " + user.lastName)
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    HStack {
                                        Image(systemName: user.callType == "Incoming" || user.callType == "Missed" ? "phone.arrow.down.left.fill" : "phone.arrow.up.right.fill")
                                            .font(.headline)
                                        Text(user.callType)
                                            .font(.subheadline)
                                    }
                                    .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack(alignment: .center, spacing: 10) {
                                    Text(user.date)
                                        .foregroundStyle(.gray)
                                        .font(.subheadline)

                                    NavigationLink {
                                        DetailView()
                                    } label: {
                                        Image(systemName: "info.circle")
                                            .foregroundStyle(.blue)
                                            .font(.title2)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            DividerView(leading: dividerLeading)
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .searchable(text: $vm.searchText, placement: .navigationBarDrawer)
                .navigationTitle("Calls")
            }
        }
    }
    
    
}

//#Preview {
//    CallsView()
//}
