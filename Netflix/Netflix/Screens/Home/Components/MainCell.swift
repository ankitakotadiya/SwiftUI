import SwiftUI

struct MainCell: View {
    var imageWidth: CGFloat = .zero
    var imageHeight: CGFloat = .zero
    var title: String = "Some Title"
    var categories: [String] = []
    var imageURL: URL?
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            AsyncImageView(url: imageURL) { image in
                image
                    .resizable()
//                    .scaledToFill()
            }
            
            VStack(alignment: .center, spacing: 15) {
                Text(title)
                    .font(.largeTitle)
                    .lineLimit(1)
                
                HStack {
                    ForEach(categories, id: \.self) { category in
                        
                        Text(category)
                            .lineLimit(1)
                        
                        if categories.last != category {
                            Circle()
                                .fill(.white)
                                .frame(width: 3, height: 3)
                        }
                    }
                }
                .font(.callout)
                .foregroundStyle(.white)
                
                
                HStack(spacing: 10) {
                    actionButtons(label: "Play", icon: "play.fill", foregroundColor: Color.Custom.gray, backgroundColor: .white)
                    
                    actionButtons(label: "My List", icon: "plus", foregroundColor: Color.white, backgroundColor: Color.Custom.gray)
                }
                .padding(.horizontal)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background {
                LinearGradient(colors: [.black.opacity(0), .black.opacity(0.3), .black.opacity(0.3)], startPoint: .top, endPoint: .bottom)
            }
        }
        .aspectRatio(0.8, contentMode: .fit)
        .cornerRadius(10)
        .padding()
    }
    
    private func actionButtons(label: String, icon: String, foregroundColor: Color, backgroundColor: Color) -> some View {
        
        Button(action: {
            
        }, label: {
            HStack(content: {
                Image(systemName: icon)
                Text(label)
            })
        })
        .lineLimit(1)
        .font(.callout)
        .frame(maxWidth: .infinity)
        .foregroundStyle(foregroundColor)
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(backgroundColor)
        }
    }
}

//#Preview {
//    MainCell()
//}
