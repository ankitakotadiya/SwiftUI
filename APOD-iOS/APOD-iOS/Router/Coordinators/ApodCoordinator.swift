import SwiftUI

enum ApodFlow: Route {
    case apod
    case fav
}

enum FavouriteFlow: Route {
    case favourite
    case apod(Date)
}

enum ApodListFlow: Route {
    case apodList
}

enum SettingsFlow: Route {
    case settings
    case upgrade
}

struct ApodCoordinator: View {
    @StateObject private var router: Router<ApodFlow> = Router<ApodFlow>(root: .apod)
    @EnvironmentObject private var tabRouter: TabRouter<AppTab>
    
    var body: some View {
        NavigationStackView(router: router) { route in
            Group {
                switch route {
                case .apod:
                    if case .today(let date) = tabRouter.selectedTab {
                        ApodView(viewModel: ApodViewModel(selectedDate: date))
                    }
                    
                case .fav:
                    FavouritesView()
                }
            }
            .environmentObject(router)
        }
    }
}
