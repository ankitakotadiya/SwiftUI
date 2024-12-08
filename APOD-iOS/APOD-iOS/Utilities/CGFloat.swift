import Foundation
import UIKit

// Scales the CGFloat value based on the screen width and device type
extension CGFloat {
    var scaled: CGFloat {
        let scalingFactor: CGFloat = (Utils.device == .iPad)
        ? (Utils.isLandScape ? 0.8 : 0.5) // iPad: 0.8 in landscape, 0.6 otherwise
        : (Utils.isLandScape ? 1.5 : 0.45)
        
        return self * ((Utils.screenWidth) / ((Utils.screenHeight) * scalingFactor))
    }
}

extension Int {
    var scaled: CGFloat {
        CGFloat(self).scaled
    }
}

// Scales the CGSize dimensions (width and height)
extension CGSize {
    var scaled: CGSize {
        CGSize(width: self.width.scaled, height: self.height.scaled)
    }
}
