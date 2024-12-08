import Foundation
import SwiftUI

struct SettingsCoordinator: View {
    @StateObject private var router: Router<SettingsFlow> = Router<SettingsFlow>(root: .settings)
    
    var body: some View {
        NavigationStackView(router: router) { route in
            Group {
                switch route {
                case .settings:
                    SettingsView()
                case .upgrade:
                    UpgradeView()
                }
            }
            .environmentObject(router)
        }
    }
}
