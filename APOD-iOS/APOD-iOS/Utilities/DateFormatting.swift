import Foundation

protocol DateFormatting {
    func dateFromString(_ strDate: String?, dateStyle: DateStyle) -> Date
    func stringFromDate(date: Date, dateStyle: DateStyle) -> String
}

enum DateStyle {
    case short
    case monthOnly
    case custom(String)
    
    var format: String {
        switch self {
        case .short:
            return "yyyy-MM-dd"
        case .monthOnly:
            return "MMMM yyyy"
        case .custom(let style):
            return style
        }
    }
}

// DateFormatter configured for APOD dates
struct DefaultDateFormatter: DateFormatting {
	private var dateAndTimeFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
        formatter.dateFormat = DateStyle.short.format
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
		return formatter
	}()
    
    func dateFromString(_ strDate: String?, dateStyle: DateStyle) -> Date {
        dateAndTimeFormatter.dateFormat = dateStyle.format
        guard let strdate = strDate else {return Date() }
        return dateAndTimeFormatter.date(from: strdate) ?? Date()
    }
    
    func stringFromDate(date: Date, dateStyle: DateStyle) -> String {
        dateAndTimeFormatter.dateFormat = dateStyle.format
        return dateAndTimeFormatter.string(from: date)
    }
}
