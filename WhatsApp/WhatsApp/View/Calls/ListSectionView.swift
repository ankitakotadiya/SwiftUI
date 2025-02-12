import SwiftUI

struct ListSectionView: View {
    
    let detailModel: ChatViewModel.DetailRowModel
    @State private var switchState: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            if let icon = detailModel.icon {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(iconColor(for: detailModel.title))
                    }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(detailModel.title.rawValue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let description = detailModel.description {
                    Text(description)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let detailDisclosure = detailModel.detailDisclosure {
                Text(detailDisclosure)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            
            if detailModel.title == .lock {
                Toggle(isOn: $switchState) {
                    
                }
            } else {
                Button(action: {}, label: {
                    Image(systemName: "chevron.forward")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .systemGray3))
                    
                })
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
    
    private func iconColor(for row: ChatViewModel.DetailsRowType) -> Color {
        switch row {
        case .labels:
            return Color(uiColor: .systemIndigo)
        case .media, .disappear, .lock, .encryption:
            return .blue
        case .starred, .photos:
            return Color(uiColor: .systemYellow)
        case .notification:
            return Color(uiColor: .systemGreen)
        case .wallpaper:
            return Color(uiColor: .magenta)
        case .contact:
            return .gray
        case .share, .favourite, .export, .clear, .block, .report:
             return .white
        }
    }
}

//#Preview {
//    ListSectionView()
//}
