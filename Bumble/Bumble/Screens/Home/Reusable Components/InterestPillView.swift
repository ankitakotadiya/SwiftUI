import SwiftUI

struct UserInterests: Identifiable, Hashable {
    let id = UUID().uuidString
    var iconName: String? = nil
    var emoji: String? = nil
    var text: String
}
struct InterestPillGridView: View {
    var interests: [UserInterests]? = []
    
    var body: some View {
        ZStack {
            let column = GridItem(.flexible(), spacing: 10, alignment: .leading)
            let columns = Array(repeating: column, count: 2)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10, content: {
                if let interests {
                    ForEach(interests, id: \.self) { interest in
                        InterestPillView(icon:interest.iconName, emoji: interest.emoji, text: interest.text)
                    }
                } else {
                    EmptyView()
                }
            })
        }
    }
}

struct InterestPillView: View {
    var icon: String? = nil
    var emoji: String? = nil
    var text: String? = nil
    
    var body: some View {
        
        HStack {
            if let icon {
                Image(systemName: icon)
            } else if let emoji {
                Text(emoji)
            }
            
            if let text {
                Text(text)
                    .lineLimit(1)
            }
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(Color.Custom.yellow)
        )
    }
}

//#Preview {
//    InterestPillView()
//}
