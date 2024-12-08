import Foundation
import SwiftUI

enum DynamicTypeOption {
    case preset
    case custom
}
extension DynamicTypeSize {
    // Defines a range of dynamic type sizes based on the device type
    private static var customDeviceSize: ClosedRange<DynamicTypeSize> {
        Utils.device == .iPhone
        ? .xSmall...accessibility1
        : .xLarge...accessibility5
    }
    
    // Specifies the default dynamic type size
    private static var defaultSize: ClosedRange<DynamicTypeSize> {
        .xSmall...large
    }
    
    static func dynamicTypeSizeAccessibility(for option: DynamicTypeOption) -> ClosedRange<DynamicTypeSize> {
        option == .preset ? defaultSize : customDeviceSize
    }
}
