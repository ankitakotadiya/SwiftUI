import Foundation

final class TabRouter<T: Route>: ObservableObject {
    @Published var selectedTab: T
    
    init(selectedTab: T) {
        self.selectedTab = selectedTab
    }
    
    func switchTab(to tab: T) {
        selectedTab = tab
    }
}
