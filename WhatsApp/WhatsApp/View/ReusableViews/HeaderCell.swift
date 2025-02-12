import SwiftUI

struct HeaderCell: View {
    var titles: [String] = ["All", "Unread", "Favourites", "Group"]
    @Binding var selectedTitle: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(titles, id: \.self) { title in
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(title == selectedTitle ? Color.black.opacity(0.8) : Color.gray)
                        .frame(minWidth: 35)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background {
                            Capsule().fill(selectedTitle == title ? Color.blue.opacity(0.2) : Color(uiColor: UIColor.systemGray6))
                        }
                        .onTapGesture {
                            selectedTitle = title
                        }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .animation(.smooth, value: selectedTitle)
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    HeaderCell()
//}
