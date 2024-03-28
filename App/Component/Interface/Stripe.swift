import SwiftUI

struct Stripe: View {
    
    let axis: Axis
    
    init(_ axis: Axis) {
        self.axis = axis
    }
    
    var stripe: some View {
        Rectangle()
            .fill(Color.stripe)
    }
    
    var body: some View {
        switch axis {
        case .horizontal:
            return stripe
                .frame(height: 2)
        case .vertical:
            return stripe
                .frame(width: 2)
        }
    }
}
