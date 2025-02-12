import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var vm: ChatViewModel
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    topHeader
                    mediaView
                    aboutMe
                    callHistory
                    
                    ForEach(vm.detailSections) { section in
                        VStack(spacing: 8) {
                            ForEach(Array(section.rows.enumerated()), id: \.element.id) { index, row in
                                
                                if section.title == .share || section.title == .report {
                                    Text(row.title.rawValue)
                                        .foregroundStyle(row.title == .clear || row.title == .block || row.title == .report ? .red : .blue)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } else {
                                    ListSectionView(detailModel: row)
                                }
                                
                                // Add Divider only if it's NOT the last row
                                if index < section.rows.count - 1 {
                                    Divider()
                                        .padding(.leading, section.title == .share || section.title == .report ? 16 : 51)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding([.top, .bottom],8)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
                .navigationTitle("Contact Info")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // Perform Action
                        } label: {
                            Text("Edit")
                        }
                    }
                }
            }
            .background(Color(uiColor: .systemGray6))
        }
    }
    
    private var topHeader: some View {
        VStack {
            if let user = vm.users.first {
                ProfileImageView(imageURL: user.imageURL)
                
                Text(user.firstName + " " + user.lastName)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(user.phone)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func mediaButton(imageName: String, title: String, action: @escaping ()-> Void) -> some View {
        Button(action: action, label: {
            VStack(alignment: .center, spacing: 5) {
                Image(systemName: imageName)
                    .foregroundStyle(.blue)
                Text(title)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
            }
        })
    }
    
    private var mediaView: some View {
        HStack(spacing: 10) {
            mediaButton(imageName: "message", title: "Message") {
                // Perform Action
            }
            
            mediaButton(imageName: "phone", title: "Audio") {
                // Perform Action
            }
            
            mediaButton(imageName: "video", title: "Video") {
                // Perform Action
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    private var aboutMe: some View {
        Group {
            if let user = vm.users.first {
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.aboutMe)
                        .font(.subheadline)
                    
                    Text(user.date)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var callHistory: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(vm.users.first?.date ?? "7 Feb 2025")
            
            HStack(spacing: 20) {
                Text("6:47 PM")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                
                VStack(alignment: .leading) {
                    Label("Incoming voice call", systemImage: "phone.fill")
                    
                    Text("21 minutes, 27 seconds (6.4 MB)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

//#Preview {
//    DetailView()
//}
