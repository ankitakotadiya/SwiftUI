import SwiftUI

enum RateOption: String, CaseIterable {
    case dislike
    case like
    case love
    
    var title: String {
        switch self {
        case .dislike:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "Love this"
        }
    }
    
    var icon: String {
        switch self {
        case .dislike:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {
    var onPressRateOption: ((RateOption) -> Void)?
    @State private var showPopOver: Bool = false
    var onPressRate: (() -> Void)?
    
    var body: some View {
        
//        Menu {
//            ZStack {
//                Color.Custom.gray.ignoresSafeArea()
//                
//                HStack(spacing: 12) {
//                    ForEach(RateOption.allCases, id: \.self) { option in
//                        ratebutton(for: option)
//                    }
//                }
//            }
//        } label: {
//            VStack(spacing: 8) {
//                Image(systemName: "hand.thumbsup")
//                    .font(.title)
//                
//                Text("Rate")
//                    .font(.callout)
//                    .foregroundStyle(Color.Custom.lightGray)
//            }
//            .foregroundStyle(.white)
//        }
//        .padding(8)

        
        Button(action: {
            showPopOver = true
            onPressRate?()
        }, label: {
            VStack(spacing: 8) {
                Image(systemName: "hand.thumbsup")
                    .font(.title)
                
                Text("Rate")
                    .font(.callout)
                    .foregroundStyle(Color.Custom.lightGray)
            }
            .foregroundStyle(.white)
        })
        .padding(8)
//        .popover(isPresented: $showPopOver, content: {
//            ZStack {
//                Color.Custom.gray.ignoresSafeArea()
//                
//                HStack(spacing: 12) {
//                    ForEach(RateOption.allCases, id: \.self) { option in
//                        ratebutton(for: option)
//                    }
//                }
//            }
////            .presentationCompactAdaptation(.popover)
//        })
    }
    
    private func ratebutton(for option: RateOption) -> some View {
        VStack(spacing: 8) {
            Image(systemName: option.icon)
                .font(.title)
            
            Text(option.title)
                .font(.callout)
                .padding(5)
        }
        .foregroundStyle(.white)
        .padding(4)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopOver = false
            onPressRateOption?(option)
        }
    }
}

//#Preview {
//    RateButton()
//}
