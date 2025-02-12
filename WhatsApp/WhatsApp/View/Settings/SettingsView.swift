import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: ChatViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(vm.sectionData) { section in
                    Section {
                        ForEach(section.rows) { row in
                            
                            if section.title == .profile, row.title == .profile, let user = vm.users.first {
                                
                                profileRow(for: user)
                                    .padding(5)
                            } else {
                                rowView(for: row)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Settings")
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer)
        }
    }
    
    private func profileRow(for user: User) -> some View {
        HStack {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing:10) {
                Text(user.firstName + " " + user.lastName)
                    .font(.title3)
                
                Text("Busy")
                    .font(.subheadline)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "square.and.arrow.up")
                .foregroundStyle(.blue)
                .padding(10)
                .background {
                    Circle().fill(Color(uiColor: UIColor.systemGray6))
                }
        }
    }
    
    private func rowView(for row: ChatViewModel.SettingsModel) -> some View {
        HStack {
            Image(systemName: row.icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(iconColor(for: row.title))
                }
            
            Text(row.title.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {}, label: {
                Image(systemName: "chevron.forward")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemGray3))
                
            })
        }
    }
    
    private func iconColor(for row: ChatViewModel.RowType) -> Color {
        switch row {
        case .profile:
            return .white
        case .avtar, .communities:
            return Color(uiColor: .systemBlue)
        case .ad:
            return Color(uiColor: .systemPurple)
        case .business:
            return Color(uiColor: .systemIndigo)
        case .fav:
            return Color(uiColor: .systemPink)
        case .broadcast, .chats, .data:
            return Color(uiColor: .systemGreen)
        case .starred, .invite:
            return Color(uiColor: .systemYellow)
        case .devices:
            return Color(uiColor: .systemMint)
        case .account:
            return Color(uiColor: .tintColor)
        case .privacy:
            return Color(uiColor: .systemCyan)
        case .notification:
            return Color(uiColor: .systemRed)
        case .help:
            return .blue
        }
    }
}

//#Preview {
//    SettingsView()
//}
