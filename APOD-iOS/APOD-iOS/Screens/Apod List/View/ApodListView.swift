
import SwiftUI

struct ApodListView: View {
    @StateObject private var viewModel: ApodListViewModel = ApodListViewModel()
    @State private var showAlert: Bool = false
    @State private var expandedIndices: Set<Int> = []
    @ScaledMetric private var space: CGFloat = 10
    var body: some View {
        NavigationStack {
            ZStack {
                Color.System.systemBackground.ignoresSafeArea()
                
                if case .loaded(let apods) = viewModel.state {
                    GeometryReader { geo in
                        List(Array(apods.enumerated()), id: \.offset) { (index,apod) in
                            VStack(alignment: .leading, spacing: space) {
                                AsyncImageView(url: apod.url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }
                                .frame(maxWidth: geo.size.width, alignment: .center)
                                .frame(height: geo.size.height * 0.40)
                                .clipped()
                                
                                VStack(alignment: .leading, spacing: space) {
                                    HStack(spacing: 10) {
                                        Button {
                                            // Action Here

                                        } label: {
                                            Image(systemName: "heart")
                                                .foregroundStyle(Color.Custom.tealColor)
                                        }
                                        
                                        Button {
                                            // Action Here
                                        } label: {
                                            Image(systemName: "ellipsis.message")
                                                .foregroundStyle(Color.Custom.tealColor)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Button {
                                            // Action Here
                                        } label: {
                                            Image(systemName: "square.and.arrow.up")
                                                .foregroundStyle(Color.Custom.tealColor)
                                        }
                                        
                                    }
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(apod.explanation)
                                        .font(.callout)
                                        .lineLimit(expandedIndices.contains(index) ? nil : 3)
                                        .foregroundStyle(Color.Custom.charcol)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .onTapGesture {
                                            toggleExpansion(for: index)
                                        }
                                        .accessibilityIdentifier("ExplanationLabel")
                                    
                                    Text(apod.date)
                                        .font(.callout)
                                        .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16.scaled)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .listRowInsets(EdgeInsets(top: space, leading: 0, bottom: space, trailing: 0))
                            .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
                        }
                        .listStyle(.inset)
                        .accessibilityIdentifier("ApodList")
                    }
                }
                
                if case .loading = viewModel.state {
                    LoadingView()
                }
            }
            .onAppear(perform: {
                loadData()
            })
            .onChange(of: viewModel.startDate, perform: { value in
                loadData()
            })
            .onChange(of: viewModel.state.erroString, perform: { value in
                if value != nil {
                    showAlert = true
                }
                    
            })
            .alert("Error", isPresented: $showAlert, actions: {
                Button {
                    showAlert = false
                } label: {
                    Text("Cancel")
                }

            }, message: {
                if let errorString = viewModel.state.erroString {
                    Text(errorString)
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    startDatePicker
                }
            })
        }
    }
    
    private func toggleExpansion(for index: Int) {
        if expandedIndices.contains(index) {
            expandedIndices.remove(index)
        } else {
            expandedIndices.insert(index)
        }
    }
    
    private func loadData() {
        Task(priority: .background) {
            await viewModel.getList()
        }
    }
    
    private var startDatePicker: some View {
        DatePicker("From", selection: $viewModel.startDate, in: viewModel.apodDate...Date.now, displayedComponents: .date)
            .labelsHidden()
            .datePickerStyle(.compact)
            .accessibilityIdentifier("ApodListDatePicker")
    }
}

//#Preview {
//    ApodListView()
//}
