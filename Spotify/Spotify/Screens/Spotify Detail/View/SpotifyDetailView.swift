import SwiftUI

struct SpotifyDetailView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    var body: some View {
        ZStack {
            Color.Custom.background.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    if let movie = viewModel.movies.first {
                        
                        AsyncImageView(url: movie.imageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        }
//                        .frame(maxWidth: .infinity, alignment: .top)
                        .frame(height: 300)
                        .clipped()
                        .overlay(alignment: .bottomLeading) {
                            Text(movie.title)
                                .font(.title.bold())
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .padding()
                        }
                        
                        // Description View
                        detailView(for: movie)
                            .padding(.horizontal)
                    }
                    
                    // List view
                    ForEach(viewModel.movies, id: \.self) { movie in
                        MovieListCell(imageURL: movie.imageURL, title: movie.title, subTitle: movie.overview)
                    }
                    .padding(.horizontal)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    private func detailView(for movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.overview)
                .foregroundStyle(Color.Custom.lightGray)
                .lineLimit(2)
            
            HStack(alignment: .top, spacing: 5) {
                Label(
                    title: {
                        Text("Directed by")
                            .foregroundStyle(Color.Custom.lightGray)
                        
                        Text(viewModel.user.name)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    },
                    icon: {
                        Image(systemName: "apple.logo")
                            .foregroundStyle(Color.Custom.green)
                            .fontWeight(.semibold)
                    }
                )
            }
            .font(.callout)
            .lineLimit(1)
            
            Text("Ratings: \(String(format: "%.1f", movie.voteAverage))")
                .foregroundStyle(Color.Custom.lightGray)
            
            ShareView()
                
        }
        .font(.callout)
        
    }
}

//#Preview {
//    SpotifyDetailView()
//}
