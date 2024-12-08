import SwiftUI
import UIKit

struct SettingsView: View {
    
    @StateObject private var viewModel: SettingsViewModel
    @EnvironmentObject private var router: Router<SettingsFlow>
    @State private var showMail: Bool = false
    
    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.System.systemBackground.ignoresSafeArea()
            
            List {
                ForEach(viewModel.sectioData, id: \.self) { sections in
                    Section {
                        ForEach(sections.rows, id: \.self) { row in
                            rowView(for: row)
                        }
                    } header: {
                        header(for: sections.title)
                    }
                }
            }
            .listStyle(.grouped)
            .accessibilityIdentifier("SettingsList")
        }
        .navigationTitle("Settings")
        .sheet(isPresented: $showMail) {
            MailView(isShowing: $showMail)
        }
    }
    
    private func header(for title: String) -> some View {
        Text(title)
            .foregroundStyle(Color.Custom.charcol)
            .lineLimit(1)
            .font(.headline)
    }
    
    private func rowView(for row: SettingsViewModel.SettingsModel) -> some View {
        HStack {
            if let icon = row.icon {
                Image(systemName: icon)
            }
            
            Group {
                switch row.value {
                case .share(let link):
                    share(for: link, label: Text(row.title))
                    
                case .feedback:
                    Text(row.title)
                    
                case .privacy, .policy:
                    openURL(link: "https://www.google.com/") {
                        Text(row.title)
                    }
                    
                default:
                    Text(row.title)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if row.value == .free {
                Text("Free")
                    .foregroundStyle(Color.Custom.charcol)
            }
        }
        .lineLimit(1)
        .font(.callout)
        .foregroundStyle(Color.Custom.charcol)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            if row.value == .viewUpgrade {
                router.navigate(to: .upgrade, option: .popover)
            } else if row.value == .feedback {
                sendEmail()
            }
        }
    }
    
    @ViewBuilder
    private func share(for link: String, label: some View) -> some View {
        if let url = URL(string: link) {
            ShareLink(item: url) {
                label
            }
        }
    }
    
    @ViewBuilder
    private func openURL(link: String, @ViewBuilder label: @escaping () -> some View) -> some View {
        if let url = URL(string: link) {
            Link(destination: url, label: {
                label()
            })
        }
    }
    
    private func sendEmail(recipient: String = "ankitakotadita@gmail.com", subject: String = "Feedback", body: String = "Sent From iPhone") {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: "mailto:\(recipient)?subject=\(subjectEncoded)&body=\(bodyEncoded)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Handle the case where Mail app is unavailable
                print("Mail app is not available.")
            }
        }
    }
}

//#Preview {
//    SettingsView()
//}
