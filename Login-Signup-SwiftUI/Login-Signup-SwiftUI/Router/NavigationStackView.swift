import SwiftUI

struct NavigationStackView<T: Route, Content: View>: View {
    @ObservedObject private var router: Router<T>
    private let content: (T) -> Content
    
    init(
        router: Router<T>,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.router = router
        self.content = content
    }
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            content(router.root)
                
                .navigationDestination(for: T.self) { route in
                    content(route)
                }
        }
        .sheet(item: $router.sheet, onDismiss: {
            router.onDismiss?()
        }, content: { route in
            NavigationStack {
                content(route)
            }
        })
        .fullScreenCover(item: $router.fullscreen, onDismiss: {
            router.onDismiss?()
        }, content: { route in
            content(route)
        })
        .popover(item: $router.popover) { route in
                content(route)
        }
//        .environmentObject(router)
    }
}

//#Preview {
//    NavigationStackView()
//}
