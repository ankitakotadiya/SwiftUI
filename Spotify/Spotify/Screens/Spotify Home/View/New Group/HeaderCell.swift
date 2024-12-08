
import SwiftUI

struct HeaderCell: View {
    var headerTitles: [String] = ["All", "Music", "Artist", "Podcast"]
    var onTapped: (() -> Void)?
    @State private var isSelected: String = "All"
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(headerTitles, id: \.self) { cell in
                    Text(cell)
                        .font(.callout)
                        .frame(minWidth: 35)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .themeColors(isSelected == cell)
                        .background(Capsule().fill(isSelected == cell ? Color.Custom.green : Color.Custom.gray))
                        .onTapGesture {
                            isSelected = cell
                            onTapped?()
                        }
                }
            }
            .padding()
        }
        .background(Color.Custom.background)
    }
}

extension View {
    func themeColors(_ isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? Color.Custom.background : .white)
    }
}

//#Preview {
//    HeaderCell()
//}
