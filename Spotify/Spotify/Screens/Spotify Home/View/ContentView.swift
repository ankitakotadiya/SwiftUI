import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Custom.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders], content: {
                        Section {
                            VStack(alignment: .leading, spacing: 16) {
                                let colums = [GridItem(.flexible(minimum: 10)), GridItem(.flexible(minimum: 10))]
                                LazyVGrid(columns: colums, content: {
                                    ForEach(viewModel.recentMovies, id: \.self) { movie in
                                        RecentCell(imageURL: movie.imageURL, title: movie.title)
                                            .onTapGesture {
                                                showDetail = true
                                            }
                                    }
                                })
                                .padding(.horizontal)
                                
                                // New Release
                                if let movie = viewModel.recentMovies.first {
                                    NewReleaseCell(imageURL: movie.imageURL, headline: "Movies", subheadline: "Comedy", title: movie.title, subtitle: movie.overview)
                                        .padding()
                                        .onTapGesture {
                                            showDetail = true
                                        }
                                }
                                
                                // Sections
                                ForEach(viewModel.sections, id: \.self) { section in
                                    VStack(alignment: .leading, spacing: 16) {
                                        Text(section.title)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .padding(.horizontal)
                                        
                                        ScrollView(.horizontal) {
                                            HStack(alignment: .top, spacing: 16) {
                                                ForEach(section.movies, id: \.self) { movie in
                                                    SectionTitleCell(imageURL: movie.imageURL, title: movie.title)
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        } header: {
                            HeaderCell()
                        }
                    })
                }
                .scrollIndicators(.hidden)
                .background(Color.Custom.background)
                .clipped()
            }
            .navigationDestination(isPresented: $showDetail) {
                SpotifyDetailView()
                    .environmentObject(viewModel)
            }
            .task {
                await viewModel.getData()
            }
        }
        .tint(Color.Custom.green)
    }
}

//#Preview {
//    ContentView()
//}
