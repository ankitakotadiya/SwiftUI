import SwiftUI

struct HomeFilterView: View {
    var filters: [String] = ["Everyone", "Trending"]
    @Binding var selectedFilter: String
    @Namespace private var namespace
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 16) {
            ForEach(filters, id: \.self) { filter in
                VStack(spacing: 8) {
                    Text(filter)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                    
                    if selectedFilter == filter {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
                .foregroundStyle(selectedFilter == filter ? Color.Custom.black : Color.Custom.gray)
                .onTapGesture {
                    selectedFilter = filter
                }
            }
        }
        .animation(.smooth, value: selectedFilter)
    }
}

//#Preview {
//    HomeFilterView()
//}
