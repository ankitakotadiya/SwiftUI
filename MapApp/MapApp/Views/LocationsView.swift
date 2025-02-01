import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationViewModel    
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                header
                    .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                locationPreviewStack
            }
            .padding()
            
        }
        .animation(.easeInOut, value: vm.showLocationList)
        .animation(.easeInOut, value: vm.mapLocation)
        .sheet(item: $vm.sheetLocation) { location in
            // Present Sheet
            LocationDetailView(location: location)
        }
        .onReceive(vm.$mapLocation, perform: { newLocation in
            vm.updateRegion(location: newLocation)
        })
    }
    
    private var header: some View {
        VStack {
            Button(action: {
                vm.toggleLocationList()
            }, label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.background)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(Color.background)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            })
            
            if vm.showLocationList {
                LocationListView()
            }
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
        })
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture(perform: {
                        vm.showNextLocation(location: location)
                    })
            }
        }
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}

//#Preview {
//    LocationsView()
//}
