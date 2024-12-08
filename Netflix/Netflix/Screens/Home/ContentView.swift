import SwiftUI

struct ContentView: View {
    @State private var filters: [FilterModel] = FilterModel.mockFilter
    @State private var selectedFilter: FilterModel? = nil
    @StateObject private var viewModel = HomeViewModel()
    @State private var scrollOffset: CGFloat = 0
    @State private var showDetail: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            
            ZStack {
                LinearGradient(
                    colors: [Color.Custom.gray.opacity(1), Color.Custom.gray.opacity(0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                LinearGradient(
                    colors: [Color.Custom.darkRed.opacity(0.5), Color.Custom.darkRed.opacity(0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
            .frame(maxHeight: max(10, (300 + scrollOffset)))
            .opacity(scrollOffset < -150 ? 0 : 1)
            .animation(.easeInOut, value: scrollOffset)
            
            ScrollView(.vertical) {
                LazyVStack(alignment:.leading,
                           pinnedViews: [.sectionHeaders],
                           content: {
                    Section {
                        VStack {
                            if scrollOffset > 40 {
                                HeaderView(filters: filters, isSelected: selectedFilter) {
                                    selectedFilter = nil
                                } onTapCategory: { filter in
                                    selectedFilter = filter
                                }
                                .transition(.move(edge: .top).combined(with: .opacity))
                            }
                            
                            if let movie = viewModel.movies.last {
                                MainCell(
                                    title: movie.title,
                                    categories: movie.genres,
                                    imageURL: movie.imageURL
                                )
                                .onTapGesture {
                                    viewModel.selectedMovie = movie
                                    showDetail = true
                                }
                            }
                            
                            // MovieCell
                            movieGrid
                        }
                        .padding()
                        .animation(.smooth, value: scrollOffset)
                        
                    } header: {
                        navigationHeader
                    }
                })
                .overlay {
                    GeometryReader { geo in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                    }
                }
            }
            .clipped()
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: { offset in
                scrollOffset = offset
            })

        }
        .sheet(isPresented: $showDetail, content: {
            MovieDetail()
                .environmentObject(viewModel)
        })
        .task {
            await viewModel.getData()
        }
    }
    
    private var navigationHeader: some View {
        HStack {
            Text(User.mockUser.name)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "tv.badge.wifi")
                .font(.title3)
            
            Image(systemName: "magnifyingglass")
                .font(.title3)
        }
        .foregroundStyle(Color.white)
        .padding()
        .background(.black)
        
    }
    
    private var movieGrid: some View {
        VStack(alignment: .leading) {
            ForEach(Array(viewModel.sections.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading) {
                    Text(row.title)
                        .foregroundStyle(.white)
                        .font(.title)
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(Array(row.movies.enumerated()), id: \.offset) { (index, movie) in
                                MovieCell(
                                    title: movie.title,
                                    isRecentlyAdded: movie.isRecentlyAdded,
                                    topTenRanking: rowIndex == 1 ? index + 1 : nil,
                                    imageURL: movie.imageURL
                                )
                                .onTapGesture {
                                    viewModel.selectedMovie = movie
                                    showDetail = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
//#Preview {
//    ContentView()
//}
