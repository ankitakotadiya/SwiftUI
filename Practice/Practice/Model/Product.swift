import Foundation

struct Product: Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let imageString: URL?
    let category: String
    let review: String
    
    let isSubtitle: Bool = {
        Bool.random()
    }()
    
    static var mockProducts: [Product] {
        [
            Product(id: 1, name: "Essence Mascara Lash Princess", description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "beauty", review: "2"),
            
            Product(id: 2, name: "Eyeshadow Palette with Mirror", description: "The Eyeshadow Palette with Mirror offers a versatile range of eyeshadow shades for creating stunning eye looks. With a built-in mirror, it's convenient for on-the-go makeup application.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "beauty", review: "4"),
            
            Product(id: 3, name: "Powder Canister", description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "beauty", review: "3"),
            
            Product(id: 4, name: "Annibale Colombo Sofa", description: "The Annibale Colombo Sofa is a sophisticated and comfortable seating option, featuring exquisite design and premium upholstery for your living room.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "furniture", review: "3"),
            
            Product(id: 5, name: "Red Lipstick", description: "The Red Lipstick is a classic and bold choice for adding a pop of color to your lips. With a creamy and pigmented formula, it provides a vibrant and long-lasting finish.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "beauty", review: "5"),
            
            Product(id: 6, name: "Bedside Table African Cherry", description: "The Bedside Table in African Cherry is a stylish and functional addition to your bedroom, providing convenient storage space and a touch of elegance.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "furniture", review: "6"),
            
            Product(id: 7, name: "Wooden Bathroom Sink With Mirro", description: "The Wooden Bathroom Sink with Mirror is a unique and stylish addition to your bathroom, featuring a wooden sink countertop and a matching mirror.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "furniture", review: "4"),
            
            Product(id: 8, name: "Cat Food", description: "Nutritious cat food formulated to meet the dietary needs of your feline friend.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "groceries", review: "3"),
            
            Product(id: 9, name: "Essence Mascara Lash Princess", description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "groceries", review: "2"),
            
            Product(id: 10, name: "Chicken Meat", description: "Fresh and tender chicken meat, suitable for various culinary preparations.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "groceries", review: "2"),
            
            Product(id: 11, name: "Wooden Bathroom Sink With Mirro", description: "The Wooden Bathroom Sink with Mirror is a unique and stylish addition to your bathroom, featuring a wooden sink countertop and a matching mirror.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "furniture", review: "4"),
            
            Product(id: 12, name: "Cat Food", description: "Nutritious cat food formulated to meet the dietary needs of your feline friend.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "groceries", review: "3"),
            
            Product(id: 13, name: "Essence Mascara Lash Princess", description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "groceries", review: "2"),
            
            Product(id: 14, name: "Chicken Meat", description: "Fresh and tender chicken meat, suitable for various culinary preparations.", imageString: URL(string: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png"), category: "groceries", review: "2")
        ]
    }
}
