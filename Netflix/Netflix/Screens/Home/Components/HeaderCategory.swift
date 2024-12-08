import SwiftUI

struct HeaderCategory: View {
    var title: String = "Some Title"
    var isSelected: Bool = false
    var isDropdown: Bool = false
    
    var body: some View {
        
        HStack(spacing: 5) {
            Text(title)
               
            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }
        .font(.callout)
        .foregroundStyle(Color.Custom.lightGray)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background {
            ZStack {
                Capsule()
                    .stroke(Color.Custom.lightGray, lineWidth: 1)
                //                .stroke(Color.Custom.lightGray, lineWidth: 1)
                //                .fill(isSelected ? Color.Custom.gray : .clear)
                
                Capsule()
                    .fill(isSelected ? Color.Custom.gray : .clear)
            }
        }
    }
}

//#Preview {
//    HeaderCategory()
//}
