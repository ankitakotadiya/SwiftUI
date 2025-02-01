import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    var body: some View {
        
        List(vm.locations) { location in
            Button {
                // Show next locaion
                vm.showNextLocation(location: location)
            } label: {
                listRowView(location: location)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//#Preview {
//    LocationListView()
//}
