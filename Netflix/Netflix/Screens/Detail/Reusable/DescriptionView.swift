import SwiftUI

struct DescriptionView: View {
    
    var title: String? = nil
    var subtitle: String? = nil
    var isTopten: Int? = nil
    var cast: String? = "Ankita Kotadia"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(spacing: 5) {
                Text("New")
                    .foregroundStyle(.green)
                
                Text("2024 4 Seasons")
                
                Button(action: {}, label: {
                    Image(systemName: "text.bubble.rtl")
                    
                })
            }
            .foregroundStyle(Color.Custom.lightGray)
            .lineLimit(1)
            .font(.footnote)
            
            HStack(spacing: 5) {
                if let isTopten {
                    VStack(spacing: -4) {
                        Text("TOP")
                            .font(.caption2)
                        
                        Text("10")
                            .font(.headline)
                    }
                    .frame(width: 28, height: 28)
                    .background(Color.Custom.red)
                    .foregroundStyle(.white)
                    
                    Text("#\(isTopten) in TV Shows Today")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
            }
            
            VStack(alignment: .center, spacing: 5) {
                Button(action: {
                    
                }, label: {
                    actionButtons(title: "Play", icon: "play", foregroundColor: Color.Custom.gray, backgroundColor: .white)
                })
                
                Button(action: {
                    
                }, label: {
                    actionButtons(title: "Download", icon: "arrow.down", foregroundColor: .white, backgroundColor: Color.Custom.gray)
                })
            }
            
            if let subtitle {
                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(Color.Custom.lightGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if let cast {
                Text(cast)
                    .font(.callout)
                    .foregroundStyle(Color.Custom.lightGray)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
    }
    
    private func actionButtons(title: String, icon: String, foregroundColor: Color, backgroundColor: Color) -> some View {
        HStack {
            Image(systemName: icon)
            Text(title)
        }
        .font(.body)
        .lineLimit(1)
        .foregroundStyle(foregroundColor)
        .frame(maxWidth: .infinity)
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(backgroundColor)
        }
    }
}

//#Preview {
//    DescriptionView()
//}
