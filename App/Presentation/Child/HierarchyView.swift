import SwiftUI

struct HierarchyView: View {
    
    @EnvironmentObject var state: RootState
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ExpandableView("Image Assets") {
                    AssetListView()
                }
                Stripe(.horizontal)
                ExpandableView("State Variables") {
                    StateListView()
                }
                Stripe(.horizontal)
                ExpandableView("View Structure") {
                    ViewTreeView()
                }
            }
            .environmentObject(state)
        }
        .frame(width: 300)
        .background(Color.fill.ignoresSafeArea())
    }
}
