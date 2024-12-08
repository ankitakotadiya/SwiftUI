import SwiftUI
import SwiftData

struct ApodView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
//    @State private var selectedDate: Date = Date.now
    @State private var selectedImage: Image? = nil
    @State private var gifTapped: Bool?
    @State private var showAlert = false
    @State private var apodState: ApodState?
    @State private var navigate: Bool = false
    @EnvironmentObject private var router: Router<ApodFlow>
    @EnvironmentObject private var tabRouter: TabRouter<AppTab>
    @StateObject private var viewModel: ApodViewModel
    
    init(viewModel: ApodViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
//        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    //                    if let apod = viewModel.state.apod { // Once response is received
                    ScrollView {
                        VStack(alignment: .leading,
                               content: {
                            if let apod = viewModel.state.apod {
                                // Image/Video/Gif
                                MediaContentView(
                                    imageName: apod.date,
                                    mediaURL: apod.url,
                                    mediaType: apod.mediaType,
                                    maxWidth: geometry.size.width,
                                    maxHeightFactor: geometry.size.height * 0.55,
                                    onTappedImage: { image in
                                        selectedImage = image
                                    },
                                    onGifTapped: { isGifTapped in
                                        gifTapped = isGifTapped
                                    }
                                )
                                // Title & Explanation
                                description
                                Spacer()
                            }
                        })
                        .onChange(of: viewModel.state.errorString, perform: { value in
                            showAlert = true
                        })
                        .alert(isPresented: $showAlert, error: AppError.NetworkManagerError(.networkError), actions: {
                            Button(role: .cancel) {
                                showAlert = false
                            } label: {
                                Text("Cancel")
                            }

                        })
                    }
                    //                    }
                    
                    // ProgressView
                    if case .loading = viewModel.state {
                        LoadingView()
                    }
                    
                    // Full Screen Image
                    if selectedImage != nil {
                        fullScreenView(geometry)
                            .onTapGesture {
                                self.selectedImage = nil
                            }
                    }
                    
                    // Full Screen Gif
                    if gifTapped != nil {
                        fullScreenView(geometry)
                            .onTapGesture {
                                self.gifTapped = nil
                            }
                    }
                }
                .animation(.smooth, value: selectedImage)
                .animation(.smooth, value: gifTapped)
            }
            .navigationTitle(Identifiers.Apod.navTitle)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        Task {
                            await viewModel.toggleFavourite(viewModel.selectedDate)
                        }
                    }, label: {
                        Image(systemName: viewModel.state.apod?.isFavourite ?? false ? "heart.fill" : "heart")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    datePicker // Right bar button item
                }
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(action: {
                        tabRouter.selectedTab = .favourites
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
//        }
//        .onAppear(perform: {
//            viewModel.loadData()
////            loadData(for: viewModel.selectedDate) // Load APOD for `Today`
//        })
        .onChange(of: viewModel.selectedDate, perform: { _ in
            viewModel.loadData() // Load data when date change
        })
        .onDisappear {
            Task(priority: .background) {
                await viewModel.cleanUpResource()
            }
        }
    }
}

// Api Extension
extension ApodView {
    private func loadData(for date: Date) {
        Task {
            await viewModel.load(strDate: viewModel.dateFormatting.stringFromDate(date: date, dateStyle: .short))
        }
    }
}

// View Extensions
extension ApodView {
    // Fullscreen View to display Image/Gif
    private func fullScreenView(_ geometry: GeometryProxy) -> some View {
        ZStack {
            Color.black
            
            if let selectedImage = selectedImage {
                fullScreenImageContent(selectedImage, geometry: geometry)
            } else if gifTapped != nil {
                fullScreenGifContent()
            }
        }
        .accessibilityIdentifier(Identifiers.Apod.fullScreenView)
        .transition(.asymmetric(insertion: .scale, removal: .scale))
    }
    
    // Fullscreen Image
    private func fullScreenImageContent(_ image: Image, geometry: GeometryProxy) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width - 20, height: geometry.size.height)
    }
    
    // Fullscreen GIF
    private func fullScreenGifContent() -> some View {
        AnimatedGifImageView(url: viewModel.state.apod?.url, isLoading: .constant(false))
            .scaledToFit()
    }
    
    // Title and Explanation
    private var description: some View {
        Group {
            // Apod Title
            Text(viewModel.state.apod?.title ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .dynamicTypeAccessibility()
                .lineLimit(3)
                .minimumScaleFactor(0.9)
           
            // Apod Explanation
            Text(viewModel.state.apod?.explanation ?? "")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(colorScheme == .light ? Color.Custom.charcol : .white)
                .padding(.vertical, 5)
                .dynamicTypeAccessibility()
        }
        .padding(.horizontal)
    }
    
    // Date Picker
    private var datePicker: some View {
        let apodDate = viewModel.dateFormatting.dateFromString(Defautls.apodStartDate, dateStyle: .short)
        return DatePicker("", selection: $viewModel.selectedDate, in: apodDate...Date(), displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.compact)
            .accessibilityIdentifier(Identifiers.Apod.datePicker)
    }
}

 
