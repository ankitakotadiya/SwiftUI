import Foundation


final class SettingsViewModel: ObservableObject {
    
    enum Titles: String, CaseIterable {
        case plus = "APOD PLUS"
        case about = "ABOUT"
        case legal = "LEGAL"
    }
    
    enum ValueType: Hashable {
        case free
        case viewUpgrade
        case share(String)
        case feedback
        case privacy
        case policy
    }
    
    struct SettingsModel: Hashable {
        let title: String
        let icon: String?
        let value: ValueType
    }
    
    struct Section: Hashable {
        let title: String
        let rows: [SettingsModel]
    }
    @Published var sectioData: [Section] = []
    
    init() {
        setData()
    }
    
    private func setData() {
        sectioData = Titles.allCases.map({ title in
            Section(title: title.rawValue, rows: rows(for: title))
        })
    }
    
    private func rows(for title: Titles) -> [SettingsModel] {
        switch title {
        case .plus:
            return [
                SettingsModel(title: "Current Tier", icon: nil, value: .free),
                SettingsModel(title: "View Upgrades", icon: nil, value: .viewUpgrade)
            ]
        case .about:
            return [
                SettingsModel(title: "Share", icon: "square.and.arrow.up", value: .share("https://www.google.com/")),
                SettingsModel(title: "Send Feedback", icon: nil, value: .feedback)
            ]
        case .legal:
            return [
                SettingsModel(title: "Privacy", icon: nil, value: .privacy),
                SettingsModel(title: "Terms and Conditions", icon: nil, value: .policy)
            ]
        }
    }
}
