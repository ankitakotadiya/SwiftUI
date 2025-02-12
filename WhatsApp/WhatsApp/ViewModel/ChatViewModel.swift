import Foundation



final class ChatViewModel: ObservableObject {
    
    @Published var users: [User]
    @Published var searchText: String = ""
    
    enum SectionType: String, CaseIterable {
        case profile = "Profile"
        case ads = "Advertise"
        case fav = "Favourite"
        case account = "Account"
        case help = "Help"
    }
    
    enum DetailSectionType: String, CaseIterable {
        case media = "Media"
        case notification = "Notification"
        case security = "Security"
        case contact = "Contact"
        case share = "Share"
        case report = "Report"
    }
    
    enum RowType: String, Hashable {
        case profile = "Profile"
        case avtar = "Avatar"
        case ad = "Advertise"
        case business = "Business tools"
        case fav = "Favourites"
        case broadcast = "Broadcast lists"
        case starred = "Starred messages"
        case communities = "Communities"
        case devices = "Linked devices"
        case account = "Account"
        case privacy = "Privacy"
        case chats = "Chats"
        case notification = "Notifications"
        case data = "Storage and data"
        case help = "Help"
        case invite = "Invite a contact"
    }
    
    enum DetailsRowType: String, Hashable {
        case labels = "Labels"
        case media = "Media, links and docs"
        case starred = "Starred"
        case notification = "Notification"
        case wallpaper = "Wallpaper"
        case photos = "Save to Photos"
        case disappear = "Disappearing messages"
        case lock = "Lock Chat"
        case encryption = "Encryption"
        case contact = "Contact details"
        case share = "Share contact"
        case favourite = "Add to Favourites"
        case export = "Export chat"
        case clear = "Clear chat"
        case block = "Block"
        case report = "Report"
    }
    
    struct Section: Identifiable {
        let title: SectionType
        let rows: [SettingsModel]
        
        var id: String {
            title.rawValue
        }
    }
    
    struct SettingsModel: Identifiable {
        let title: RowType
        let icon: String
        
        var id: String {
            title.rawValue
        }
    }
    
    struct DetailSection: Identifiable {
        let title: DetailSectionType
        let rows: [DetailRowModel]
        
        var id: String {
            title.rawValue
        }
    }
    
    struct DetailRowModel: Identifiable {
        let title: DetailsRowType
        let icon: String?
        let description: String?
        let detailDisclosure: String?
        
        var id: String {
            return title.rawValue
        }
    }
    
    @Published var sectionData: [Section] = []
    @Published var detailSections: [DetailSection] = []
    
    init() {
        users = UserService.users
        setSectionData()
        setDetailSections()
    }

    private func setSectionData() {
        sectionData = SectionType.allCases.map({ title in
            Section(title: title, rows: rows(for: title))
        })
    }
    
    private func setDetailSections() {
        detailSections = DetailSectionType.allCases.map({ title in
            DetailSection(title: title, rows: setDetailsRow(for: title))
        })
    }
    
    private func rows(for title: SectionType) -> [SettingsModel] {
        switch title {
        case .profile:
            return [
                SettingsModel(title: .profile, icon: ""),
                SettingsModel(title: .avtar, icon: "smiley.fill")
            ]
            
        case .ads:
            return [
                SettingsModel(title: .ad, icon: "speaker.wave.3.fill"),
                SettingsModel(title: .business, icon: "gift.fill")
            ]
            
        case .fav:
            return [
                SettingsModel(title: .fav, icon: "heart.fill"),
                SettingsModel(title: .broadcast, icon: "speaker.wave.3.fill"),
                SettingsModel(title: .starred, icon: "star.fill"),
                SettingsModel(title: .communities, icon: "person.3.fill"),
                SettingsModel(title: .devices, icon: "laptopcomputer")
            ]
            
        case .account:
            return [
                SettingsModel(title: .account, icon: "key.fill"),
                SettingsModel(title: .privacy, icon: "lock.fill"),
                SettingsModel(title: .chats, icon: "message"),
                SettingsModel(title: .notification, icon: "bell.badge.fill"),
                SettingsModel(title: .data, icon: "arrow.up.arrow.down")
            ]
            
        case .help:
            return [
                SettingsModel(title: .help, icon: "info"),
                SettingsModel(title: .invite, icon: "person.2.fill"),
            ]
        }
    }
    
    private func setDetailsRow(for title: DetailSectionType) -> [DetailRowModel] {
        switch title {
            
        case .media:
            return [
                DetailRowModel(title: .labels, icon: "tag.fill", description: nil, detailDisclosure: "None"),
                DetailRowModel(title: .media, icon: "photo", description: nil, detailDisclosure: "26"),
                DetailRowModel(title: .starred, icon: "star.fill", description: nil, detailDisclosure: "None")
            ]
        case .notification:
            return [
                DetailRowModel(title: .notification, icon: "bell.badge.fill", description: nil, detailDisclosure: nil),
                DetailRowModel(title: .wallpaper, icon: "sun.min.fill", description: nil, detailDisclosure: ""),
                DetailRowModel(title: .photos, icon: "square.and.arrow.down", description: nil, detailDisclosure: "")
            ]
        case .security:
            return [
                DetailRowModel(title: .disappear, icon: "timer", description: nil, detailDisclosure: "Off"),
                DetailRowModel(title: .lock, icon: "lock.rectangle.stack", description: "Lock and hide this chat on this device.", detailDisclosure: nil),
                DetailRowModel(title: .encryption, icon: "lock.fill", description: "Messages and calls are end-to-end encrypted. Tap to verify.", detailDisclosure: nil)
            ]
        case .contact:
            return [
                DetailRowModel(title: .contact, icon: "person.crop.circle", description: nil, detailDisclosure: nil)
            ]
        case .share:
            return [
                DetailRowModel(title: .share, icon: nil, description: nil, detailDisclosure: nil),
                DetailRowModel(title: .favourite, icon: nil, description: nil, detailDisclosure: nil),
                DetailRowModel(title: .export, icon: nil, description: nil, detailDisclosure: nil),
                DetailRowModel(title: .clear, icon: nil, description: nil, detailDisclosure: nil)
            ]
        case .report:
            return [
                DetailRowModel(title: .block, icon: nil, description: nil, detailDisclosure: nil),
                DetailRowModel(title: .report, icon: nil, description: nil, detailDisclosure: nil)
            ]
        }
    }
}
