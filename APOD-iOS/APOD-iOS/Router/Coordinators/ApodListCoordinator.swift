import Foundation
import SwiftUI


struct ApodListCoordinator: View {
    @StateObject private var router: Router<ApodListFlow> = Router<ApodListFlow>(root: .apodList)
    var body: some View {
        NavigationStackView(router: router) { route in
            switch route {
            case .apodList:
                ApodListView()
                    .environmentObject(router)
            }
        }
    }
}
