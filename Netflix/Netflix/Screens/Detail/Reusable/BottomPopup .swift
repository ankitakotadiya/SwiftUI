
import SwiftUI

struct BottomPopup: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showPopup: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            //            if showPopup {
            //                Color.black.opacity(0.5)
            //                    .ignoresSafeArea()
            //                    .onTapGesture {
            //                        withAnimation {
            //                            showPopup = false
            //                        }
            //                    }
            //                    .transition(.opacity) // Fade-in/out the background
            //            }
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    showPopup = false
                }
            
            if showPopup {
                VStack {
                    Text("HI this is bottom popup")
                    
                    Button("Some Action") {
                        
                    }
                    .padding()
                    .background {
                        Capsule()
                            .fill(.green)
                    }
                }
                .frame(maxHeight: 300)
                .frame(maxWidth: .infinity, alignment:.bottom)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.white).ignoresSafeArea()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

        }
        .animation(.easeInOut, value: showPopup)
    }
}

//#Preview {
//    BottomPopup_()
//}
