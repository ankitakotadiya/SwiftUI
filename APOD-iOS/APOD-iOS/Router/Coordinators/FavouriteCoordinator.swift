import Foundation
import SwiftUI


struct FavouriteCoordinator: View {
    @StateObject private var router: Router<FavouriteFlow> = Router<FavouriteFlow>(root: .favourite)
    var body: some View {
        NavigationStackView(router: router) { route in
            switch route {
            case .favourite:
                FavouritesView()
                    .environmentObject(router)
            case .apod(let date):
                ApodView(viewModel: ApodViewModel(selectedDate: date))
            }
        }
    }
}
