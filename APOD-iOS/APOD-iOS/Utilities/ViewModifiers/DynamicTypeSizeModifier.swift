import Foundation
import SwiftUI

struct DynamicTypeSizeModifier: ViewModifier {
    let dynamicType: DynamicTypeOption
    func body(content: Content) -> some View {
        content
            .dynamicTypeSize(DynamicTypeSize.dynamicTypeSizeAccessibility(for: dynamicType))
    }
}

extension View {
    func dynamicTypeAccessibility(_ dynamicType: DynamicTypeOption = .custom) -> some View {
        modifier(DynamicTypeSizeModifier(dynamicType: dynamicType))
    }
}
