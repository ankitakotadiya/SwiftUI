import Foundation
import MapKit
import Combine

@MainActor
final class LocationViewModel: ObservableObject {
    
    @Published var locations: [Location]
    @Published var mapLocation: Location
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var showLocationList: Bool = false
    @Published var sheetLocation: Location? = nil
    
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    var cancellable = Set<AnyCancellable>()
    
    init() {
        let locations = LocationDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        $mapLocation
            .dropFirst()
            .sink { [weak self] newLocation in
                self?.updateRegion(location: newLocation)
            }
            .store(in: &cancellable)
    }
    
    func updateRegion(location: Location) {
        mapRegion = MKCoordinateRegion(
            center: location.coordinates,
            span: mapSpan)
    }
    
    func toggleLocationList() {
        showLocationList.toggle()
    }
    
    func showNextLocation(location: Location) {
        mapLocation = location
        showLocationList = false
    }
    
    func nextButtonpressed() {
        // Get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
