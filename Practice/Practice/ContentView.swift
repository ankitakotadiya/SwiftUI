import SwiftUI

struct ContentView: View {
    @State private var products = Product.mockProducts
    @State private var selectedProduct: Product?
    @State private var selectedProducts: Set<Product> = []
    @State private var selectedSegment: Int = 0
    var images: [String] = [
        "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png",
        "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png",
        "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png",
        "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"
    ]
    
    var segments = ["First", "Second"]
    
    struct Section: Identifiable, Hashable {
        let id = UUID().uuidString
        let title: String
        var products: [Product]
        static var sections: [Section] {
            [
                Section(title: "Beauty", products: Product.mockProducts),
                Section(title: "Furniture", products: Product.mockProducts),
                Section(title: "Grocery", products: Product.mockProducts)
            ]
        }
    }
    
    var productSection: [Section] = Section.sections

    var body: some View {
        NavigationStack {
            
            VStack {
                tabViewImages
            }
            .padding()
        }
    }
    
    private var tabViewImages: some View {
        TabView(selection: $selectedSegment,
                content:  {
            ForEach(0..<images.count, id:\.self) { index in
                asyncImage(URL(string: images[index])) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }
                .tag(index)
            }
        })
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .tint(.green)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: .systemGray6))
        }
    }
    
    private var tabSegment: some View {
        VStack {
            segment
            tabView
        }
    }
    
    private var segment: some View {
        Picker("", selection: $selectedSegment) {
            ForEach(0..<segments.count, id:\.self) { index in
                Text(segments[index])
                    .tag(index)
                    .font(.headline)
                    .foregroundStyle(.black)
            }
        }
        .pickerStyle(.segmented)
        .foregroundStyle(.green)
    }
    
    private var tabView: some View {
        TabView(selection: $selectedSegment) {
            ForEach(0..<segments.count, id:\.self) { index in
                segmentRow(for: index)
            }
        }
        .tabViewStyle(.page)
    }
    
    private func segmentRow(for index: Int) -> some View {
        List {
            ForEach(products, id:\.self) { product in
                if index == 0 {
                    Text(product.name)
                } else {
                    Text(product.description)
                }
            }
        }
        .listStyle(.inset)
        .tag(index)
    }
    
    private var lazyVgrid: some View {
        let column = GridItem(.flexible(), spacing: 10, alignment: .leading)
        let columns = Array(repeating: column, count: 2)

        return LazyVGrid(columns: columns, alignment: .leading, spacing: 10, pinnedViews: []) {
            ForEach(products) { product in
                category(for: product)
            }
        }
        .padding()
    }
    
    private var cardList: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            insetList
        }
        .toolbar(content: {
            EditButton()
        })
    }
    
    private var insetList: some View {
        List(products, id: \.self, selection: $selectedProducts) { product in
            HStack(spacing: 10) {
                asyncImage(product.imageString) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                .frame(width: 100, height: 100)
                
                VStack(alignment:.leading, spacing: 10) {
                    Text(product.name)
                        .lineLimit(1)
                        .fontWeight(.semibold)
                    
                    Text(product.description)
                        .lineLimit(3)
                }
                .font(.callout)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color.gray.opacity(0.7))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .listRowBackground(Color.black)
        }
        .listStyle(.plain)
        .tint(.green)
    }
    
    private var defaultList: some View {
        List(Array(products.enumerated()), id:\.element, selection: $selectedProducts) { (index, product) in
            Text(product.name)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(action: {
                        deleteItem(at: index)
                    }, label: {
                        Text("Edit")
                    })
                    .tint(.green)
                }
        }
        .scrollContentBackground(.hidden) // Hides the default list background
        .background(Color.black)
    }
    
    private func deleteItem(at offset: Int) {
        products.remove(at: offset)
    }
    
    private var gridRow: some View {
        GridRow(alignment: .top) {
            ForEach(products) { product in
                category(for: product)
            }
        }
    }
    
    private var grid: some View {
        Grid(alignment: .top, horizontalSpacing: 20, verticalSpacing: 10) {
            ForEach(products) { product in
                asyncImage(product.imageString) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 100, height: 100)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .systemGray6))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var sheinProductsview: some View {
        HStack(alignment: .top ,spacing: 10) {
            sheignProductList
            sheignProductList
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private var sheignProductList: some View {
        let column = GridItem(.flexible(), spacing: 10, alignment: .top)
        let columns = Array(repeating: column, count: 1)

        return LazyVGrid(columns: columns, alignment: .leading, spacing: 10, pinnedViews: []) {
            ForEach(products.shuffled()) { product in
                VStack {
                    asyncImage(product.imageString) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                    .frame(width: 100, height: 150)
                    
                    VStack(spacing: 5) {
                        Text(product.name)
                            .lineLimit(1)
                        
                        if product.isSubtitle {
                            Text(product.description)
                                .lineLimit(3)
                        }
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .foregroundStyle(.black)
                .font(.callout)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .systemGray6))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }
    
    private var sheinFilter: some View {
        let column = GridItem(.flexible(), spacing: 10, alignment: .leading)
        let columns = Array(repeating: column, count: 2)

        return LazyVGrid(columns: columns, alignment: .leading, spacing: 10, pinnedViews: []) {
            ForEach(products) { product in
                category(for: product)
            }
        }
        .padding()
    }
    
    private func category(for product: Product) -> some View {
        Text(product.name)
            .font(.body)
            .foregroundStyle(.black)
            .lineLimit(1)
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(uiColor: .systemGray6))
                
            }
    }
    
    private func asyncImage<Content: View>(_ url: URL?, @ViewBuilder imageContent: @escaping (Image) -> Content) -> some View{
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                imageContent(image)
            case .failure(_):
                Image(systemName: "arrow.uturn.left.square")
            @unknown default:
                fatalError()
            }
        }
    }
    
    private var sheinHGrid: some View {
        let row = GridItem(.flexible(minimum: 80, maximum: 130), spacing: 10, alignment: .leading)
        let rows = Array(repeating: row, count: 3)

        return LazyHGrid(rows: rows, alignment: .top, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
            ForEach(products) { product in
                VStack(spacing: 10) {
                    asyncImage(product.imageString) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    }
                    .frame(width: 70, height: 70)
                    .background {
                        Circle()
                            .fill(Color(uiColor: .systemGray6))
                    }
                    
                    Text(product.name)
                        .font(.callout)
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .frame(width: 70)
                }
                .frame(maxHeight: 130, alignment: .top)
            }
        })
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//#Preview {
//    ContentView()
//}
