import Foundation
import SwiftUI

enum AppTab: CaseIterable {
    case updates
    case calls
    case tools
    case chats
    case settings
    
    // Tabbar titles
    var title: String {
        switch self {
        case .updates:
            return "Updates"
        case .calls:
            return "Calls"
        case .tools:
            return "Tools"
        case .chats:
            return "Chats"
        case .settings:
            return "Settings"
        }
    }
    
    // Tabbar icons
    var iconName: String {
        switch self {
        case .updates:
            return "circle.dashed.inset.filled"
        case .calls:
            return "phone"
        case .tools:
            return "gift"
        case .chats:
            return "message"
        case .settings:
            return "gear"
        }
    }
    
//     Determines the view associated with each tab
    @ViewBuilder
    var view: some View {
        switch self {
        case .chats:
            ChatsView()
        case .calls:
            CallsView()
        case .settings:
            SettingsView()
        case .updates, .tools:
            UpdatesView()
        }
    }
}

struct MainTabView: View {
    // Accessing the current color scheme (light or dark mode)
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var tabRouter: TabRouter = TabRouter()
    @StateObject private var vm = ChatViewModel()
    
    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                tab.view
                    .tabItem {
                        Label(tab.title, systemImage: tab.iconName)
                    }
            }
        }
        .environmentObject(tabRouter)
        .environmentObject(vm)
        .tint(colorScheme == .light ? Color.blue : Color.white)
    }
    
}
