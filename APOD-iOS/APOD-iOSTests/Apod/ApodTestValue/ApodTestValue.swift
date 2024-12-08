import Foundation

extension Apod {
    
    // Mock apod data
    static let testValue = Apod(
        id: "1",
        date: Constants.Dates.testDate,
        explanation: "Test Explanation",
        media_type: "image",
        title: "Test Title",
        service_version: "v1",
        url: URL(
            string: "https://"
        ),
        isFavourite: false
    )
    
    static let videoData = Apod(
        id: "2",
        date: Constants.Dates.videoDate,
        explanation: "Test Video Explanation",
        media_type: "video",
        title: "Test Video Title",
        service_version: "v1",
        url: URL(
            string: "https://www.youtube.com/embed/7QB_MOemCqs?rel=0"
        ),
        isFavourite: false
    )
    
    static let favourites: [Apod] = [
            Apod(
                id: "1",
                date: Constants.Dates.testDate,
                explanation: "Favourites Explanation",
                media_type: "image",
                title: "Test Favourite Item",
                service_version: "v1",
                url: URL(string: "https://"),
                isFavourite: true
            )
//            ,
//            
//            Apod(
//                id: "2",
//                date: Constants.Dates.testDate,
//                explanation: "Favourites Explanation",
//                media_type: "image",
//                title: "This is not Favourite Item",
//                service_version: "v1",
//                url: URL(string: "https://"),
//                isFavourite: false
//            )
        ]
}
