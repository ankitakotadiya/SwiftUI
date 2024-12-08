import Foundation
import SwiftUI

enum AppTab: Route {
    
    case today(Date = Date.now)
    case favourites
    case list
    case settings
    
    // Tabbar titles
    var title: String {
        switch self {
        case .today:
            return "Today"
        case .favourites:
            return "Favourites"
        case .list:
            return "Apod List"
        case .settings:
            return "Settings"
        }
    }
    
    // Tabbar icons
    var iconName: String {
        switch self {
        case .today:
            return "calendar"
        case .favourites:
            return "heart.fill"
        case .list:
            return "list.bullet"
        case .settings:
            return "gearshape"
        }
    }
    
//     Determines the view associated with each tab
    @ViewBuilder
    var view: some View {
        switch self {
        case .today:
            ApodCoordinator()
        case .favourites:
            FavouriteCoordinator()
        case .list:
            ApodListCoordinator()
        case .settings:
            SettingsCoordinator()
        }
    }
}

struct MainTabView: View {
    // Accessing the current color scheme (light or dark mode)
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var tabRouter: TabRouter<AppTab> = TabRouter(selectedTab: .today())
    
    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            createTab(for: .today())
            createTab(for: .favourites)
            createTab(for: .list)
            createTab(for: .settings)
        }
        .environmentObject(tabRouter)
        .tint(colorScheme == .light ? Color.Custom.tealColor : Color.Custom.extraLightTeal)
    }
    
    private func createTab(for tab: AppTab) -> some View {
        tab.view
            .tabItem { Label(tab.title, systemImage: tab.iconName) }
            .tag(tab)
    }
}
