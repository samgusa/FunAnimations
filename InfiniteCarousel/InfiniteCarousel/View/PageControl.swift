//
//  PageControl.swift
//  InfiniteCarousel
//
//  Created by Sam Greenhill on 7/17/23.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    /// Page Properties
    /// Page Indicator's view for infinite carousel, as of now, we dont have any native method to use page control seperately rather than having it merged inside pagetabview
    var totalPages: Int
    var currentPage: Int

    func makeUIView(context: Context) -> some UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        control.allowsContinuousInteraction = false

        return control
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPage
    }
}
