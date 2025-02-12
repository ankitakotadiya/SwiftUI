import Foundation

final class TabRouter: ObservableObject {
    @Published var selectedTab: AppTab = .chats
}
