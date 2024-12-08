import SwiftUI

struct MovieDetail: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var isMyList: Bool = false
    @State private var showBottomSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Color.Custom.gray.opacity(0.3).ignoresSafeArea()
            
            VStack {
                if let movie = viewModel.selectedMovie {
                    BackgroundImageCell(imageURL: movie.imageURL)
                    
                    ScrollView(.vertical) {
                        VStack {
                            DescriptionView(title: movie.title, subtitle: movie.overview, isTopten: 2)
                                .padding()
                            
                            // Button
                            buttons
                            
                            // Gris
                            grid
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            if viewModel.showBottom {
                BottomPopup(showPopup: $viewModel.showBottom)
            }
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 32) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { option  in
                // Do Something
            } onPressRate: {
                viewModel.showBottom = true
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var grid: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .foregroundStyle(.white)
                .font(.title3)
                .lineLimit(1)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),
                      alignment: .center,
                      spacing: 8,
                      pinnedViews: [],
                      content: {
                
                ForEach(viewModel.movies, id: \.self) { movie in
                    MovieCell(
                        title: movie.title,
                        isRecentlyAdded: movie.isRecentlyAdded,
                        topTenRanking: nil,
                        imageURL: movie.imageURL
                    )
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

//#Preview {
//    MovieDetail()
//}
