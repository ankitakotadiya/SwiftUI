import SwiftUI

// Coming Soon view
struct FavouritesView: View {
    @StateObject private var viewModel = FavouritesViewModel()
    @Environment(\.colorScheme) private var colorScheme
    @State private var searchTerm: String = ""
    @State private var navigate: Bool = false
    @EnvironmentObject private var router: Router<FavouriteFlow>
    @EnvironmentObject private var tabRouter: TabRouter<AppTab>
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        //        NavigationStack {
        GeometryReader { geometry in
            ZStack {
                if case .loaded(let items) = viewModel.state {
                    if items.isEmpty {
                        noFavourites
                        
                    } else {
                        // Write some code to display list here...
                        ScrollView(.vertical) {
                            ForEach(Array(viewModel.groups.enumerated()), id: \.offset) { (index, section) in
                                Section {
                                    VStack(spacing: 0) {
                                        ForEach(Array(section.rows.enumerated()), id: \.offset) { (rowIndex, apod) in
                                            RowView(for: apod)
                                        }
                                        
                                        footerView(index == viewModel.groups.count-1)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            header: {
                                headerView(for: section.title)
                            }
                            }
                        }
                        .refreshable {
                            fetchList()
                        }
                    }
                }
                
                if case .loading = viewModel.state {
                    LoadingView()
                }
            }
        }
        .navigationTitle("Favourites")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.navigate(to: .favourite)
                } label: {
                    Image(systemName: "text.insert")
                }
                
            }
        })
        //        }
        .onChange(of: viewModel.searchTerm, perform: { _ in
            viewModel.searchText()
        })
        .searchable(text: $viewModel.searchTerm)
        .onAppear(perform: {
            fetchList()
        })
        //        .navigationDestination(isPresented: $navigate) {
        //            ApodView(viewModel: ApodViewModel(selectedDate: selectedDate))
        //        }
    }
    
    private func fetchList() {
        Task(priority: .background) {
            await viewModel.fetchList()
        }
    }
    
    private func headerView(for title: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .lineLimit(1)
                .dynamicTypeAccessibility()
                .padding()
            
            divider
        }
    }
    
    private func footerView(_ isLast: Bool) -> some View {
        VStack(spacing: 0) {
            if isLast {
                Rectangle()
                    .fill(Color.System.systemBackground)
                    .frame(height: 22)
                    .frame(maxWidth: .infinity)
            } else {
                Rectangle()
                    .fill(isLast ? Color.System.systemBackground : Color.System.systemGray6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                divider
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func RowView(for apod: Apod) -> some View {
        
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                MediaContentView(
                    imageName: apod.date,
                    mediaURL: apod.url,
                    mediaType: apod.mediaType,
                    maxWidth: 150,
                    maxHeightFactor: 120) { _ in
                        tabRouter.selectedTab = .today(viewModel.convertStringToDate(date: apod.date))
                    } onGifTapped: { _ in
                        tabRouter.selectedTab = .today(viewModel.convertStringToDate(date: apod.date))
                    }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(apod.title)
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundStyle(Color.Custom.charcol)
                    
                    Text(apod.explanation)
                        .font(.callout)
                        .lineLimit(3)
                        .foregroundStyle(Color.System.systemGray)
                    
                    Text(apod.date)
                        .font(.callout)
                        .foregroundStyle(Color.System.systemGray)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .dynamicTypeAccessibility()
                .background(Color.System.systemBackground)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 120)
            .padding(.horizontal)
            
            divider
                .padding(.top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            tabRouter.selectedTab = .today(viewModel.convertStringToDate(date: apod.date))
        })
        
    }
    
    private var divider: some View {
        Divider()
            .frame(maxWidth: .infinity)
    }
    
    private func favouritesList(for items: [Apod], geometry: CGSize) -> some View {
        List(Array(items.enumerated()), id:\.element.date) {
            index,
            element in
            
            VStack(alignment: .leading, spacing: 10) {
                MediaContentView(
                    imageName: element.date,
                    mediaURL: element.url,
                    mediaType: element.mediaType,
                    maxWidth: geometry.width - 32,
                    maxHeightFactor: geometry.height * 0.30
                )
                
                dateAndFavourites(element, index: index)
                
                title(for: element)
            }
        }
        .listStyle(.plain)
        .buttonStyle(.plain)
    }
    
    private var noFavourites: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("No favourites yet.")
                .font(.headline)
                .foregroundStyle(Color(uiColor: .navigationColor))
                .dynamicTypeAccessibility()
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    @MainActor
    private func dateAndFavourites(_ element: Apod, index: Int) -> some View {
        HStack {
            Text(element.date)
                .font(.body)
                .foregroundStyle(Color.System.systemGray)
            Spacer()
            Button {
                Task {
                    await viewModel.toggleFavourite(for:element,index:index)
                }
            } label: {
                Label(
                    title: {
                        Text("Remove")
                    },
                    icon: {
                        Image(systemName: element.isFavourite ? "heart.fill" : "fill")
                    }
                )
                .font(.body)
                .foregroundStyle(Color(uiColor: .navigationColor))
                .labelStyle(.titleAndIcon)
            }
        }
        .dynamicTypeAccessibility()
    }
    
    private func title(for element: Apod) -> some View {
        Text(element.title)
            .font(.title3)
            .foregroundStyle(colorScheme == .light ? Color.Custom.charcol : Color.white)
            .fontWeight(.semibold)
            .dynamicTypeAccessibility()
            .lineLimit(2)
            .minimumScaleFactor(0.9)
    }
}

//#Preview {
//    FavouritesView()
//}
