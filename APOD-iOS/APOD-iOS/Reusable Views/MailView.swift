import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    
    @Binding var isShowing: Bool
//    @Binding var result: Result<MFMailComposeResult, Error>?
    var subject: String = "Feedback"
    var recipients: [String]? = ["ankitakotadita@gmail.com"]
    var body: String? = "Sent From iPhone"
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        guard MFMailComposeViewController.canSendMail() else {
            fatalError("Mail services are not available")
        }
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = context.coordinator
        mailComposerVC.setSubject(subject)
        if let recipients = recipients {
            mailComposerVC.setToRecipients(recipients)
        }
        if let body = body {
            mailComposerVC.setMessageBody(body, isHTML: false)
        }
        return mailComposerVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
//        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
//            _result = result
        }
        
        // This delegate method is called when the user finishes composing the email
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            if let error = error {
//                self.result = .failure(error)
//            } else {
//                self.result = .success(result)
//            }
            
            // Dismiss the mail view
            isShowing = false
            controller.dismiss(animated: true, completion: nil)
        }
    }
}

//#Preview {
//    MailView()
//}
