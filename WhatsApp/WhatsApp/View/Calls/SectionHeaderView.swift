import SwiftUI

struct SectionHeaderView: View {
    
    let action: () -> Void
    let title: String
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        })
        .padding(.horizontal)
    }
}

//#Preview {
//    SectionHeaderView()
//}
