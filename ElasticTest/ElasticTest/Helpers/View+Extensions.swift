//
//  View+Extensions.swift
//  ElasticTest
//
//  Created by Sam Greenhill on 5/28/23.
//

import SwiftUI

// Custom View Modifiers
extension View {
    //Enables Elastic Scroll
    // NOTE: need to be added to each item inside the scrollView
    @ViewBuilder
    func elasticScroll(scrollRect: CGRect, screenSize: CGSize) -> some View {
        self
            .modifier(ElasticScrollHelper(scrollRect: scrollRect, screenSize: screenSize))
    }
}
// private helper for elastic scroll
fileprivate struct ElasticScrollHelper: ViewModifier {
    var scrollRect: CGRect
    var screenSize: CGSize
    // View Modifier Properties
    @State private var viewRect: CGRect = .zero
    // the logic here is that we are converting the scrollview offset into progress starting from zero and going to multiply the progress into the view's current minY, and thus it will move the current view further from its original place, thus creating an elastic effect.
    func body(content: Content) -> some View {
        let progress = scrollRect.minY / scrollRect.maxY
        // if you need more Elastic Then adjust it's multiplier, can go up to 1.5-2.0
        let elasticOffset = (progress * viewRect.minY) * 1.2
        // Bottom Progress and Bottom ElasticOffset
        // to start from Zero, simple remove 1 from the progress
        let bottomProgress = max(1 - (scrollRect.maxY / screenSize.height), 0)
        // if you need more Elastic Then adjust it's multiplier, can go up to 1.5-2.0
        let bottomElasticOffset = viewRect.maxY * bottomProgress * 1
        content
            .offset(y: scrollRect.minY > 0 ? elasticOffset : 0)
        // will also need to add multiplier to progress here (Progress * minY) * Multiplier
            .offset(y: scrollRect.minY > 0 ? -(progress * scrollRect.minY) : 0)
        // can guess when the scroll is over scrolling by comparing scrollview's maxY with screen size height
            .offset(y: scrollRect.maxY < screenSize.height ? bottomElasticOffset : 0)
            .offsetExtractor(coordinateSpace: "SCROLLVIEW") {
                viewRect = $0
            }
    }
}



struct View_Extensions_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
