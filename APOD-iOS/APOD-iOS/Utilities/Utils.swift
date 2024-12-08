import Foundation
import SwiftUI

struct Utils {
    enum DeviceType {
        case iPhone
        case iPad
    }
    
    // Determine the device type
    static var device: DeviceType {
        UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }
    
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var isLandScape: Bool {
        UIDevice.current.orientation.isLandscape
    }
}

struct Defautls {
    // Start date for APOD data
    static let apodStartDate: String = "1995-06-16"
}

struct Links {
    static let apiKey = "5MvMTx3RcsNNsuh4kBxtjMspgnkoUOTvLT9VpFsR"
    static let host = "https://api.nasa.gov/planetary"
}

struct Images {
    static let failedImage = "arrow.uturn.left"
//    "exclamationmark.triangle"
}

struct Identifiers {
    enum Apod {
        static let datePicker = "DatePicker"
        static let fullScreenView = "FullScreenView"
        static let mediaContentView = "MediaContentView"
        static let apodImage = "ApodImage"
        static let navTitle = "APOD"
    }
    
    enum View {
        static let imageIndicator = "LoadingIndicator"
        static let mainIndicator = "MainLoadingIndicator"
    }
    
    enum UITest {
        static let api = "-ui-testing"
    }
}

struct Errors {
    static let genericErrorMessage = "Unable to load the requested content. Please try again later."
    static let timeoutMessage = "Request timed out. Please try again."
    static let serverErrorMessage = "We are facing some issue server side. Please try again."
    static let decodingErrorMessage = "We encountered an issue while processing the data. Please try again."
    static let noInternetMessage = "Please turn on your internet connection."
    static let invalidResponse = "The server returned an invalid response. Please try again later."
}
