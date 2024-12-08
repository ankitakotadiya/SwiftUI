import SwiftUI

struct FilterModel: Hashable {
    let title: String
    let isDropDown: Bool
    
    static var mockFilter: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropDown: false),
            FilterModel(title: "Movies", isDropDown: false),
            FilterModel(title: "Catrgories", isDropDown: true)
        ]
    }
}

struct HeaderView: View {
    var filters: [FilterModel] = FilterModel.mockFilter
    var isSelected: FilterModel? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var onTapCategory: ((FilterModel) -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                if isSelected != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background {
                            Circle()
                                .stroke(lineWidth: 1)
                        }
                        .foregroundStyle(Color.Custom.lightGray)
                        .transition(AnyTransition.move(edge: .leading).combined(with: .opacity))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                }
                
                ForEach(filters, id: \.self) { filter in
                    if isSelected == nil || isSelected == filter {
                        HeaderCategory(title: filter.title, isSelected: isSelected == filter, isDropdown: filter.isDropDown)
                            .onTapGesture {
                                onTapCategory?(filter)
                            }
                    }
                }
            }
            .padding(2)
            .animation(.bouncy, value: isSelected)
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    HeaderView()
//}
