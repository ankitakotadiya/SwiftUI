import SwiftUI

struct CapsuleStyle: ButtonStyle {
    
    var bgColor = Color.blue
    var textColor = Color.white
    var hasBorder: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(
                Capsule(
                    style: .continuous
                )
                .fill(bgColor)
            )
            .overlay(content: {
                hasBorder ? Capsule().stroke(.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/) : nil
            })
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

//#Preview {
//    CapsuleStyle()
//}
