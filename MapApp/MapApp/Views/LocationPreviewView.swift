import SwiftUI

struct LocationPreviewView: View {
    
    let location: Location
    @EnvironmentObject private var vm: LocationViewModel
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8, content: {
                learnMoreButton
                nextButton
            })
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                    }
            }
        }
        .padding(6)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button(action: {
            vm.sheetLocation = location
        }, label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button(action: {
            vm.nextButtonpressed()
        }, label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.bordered)
    }
}

//#Preview {
//    LocationPreviewView()
//}
