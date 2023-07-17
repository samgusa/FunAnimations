//
//  Home.swift
//  InfiniteCarousel
//
//  Created by Sam Greenhill on 7/17/23.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    // infinite carousel properties
    // contains the first and last duplicate pages in front and back to create an infinite carousel
    @State private var fakedPages: [Page] = []

    var body: some View {
        GeometryReader {

            let size = $0.size

            TabView(selection: $currentPage, content: {
                ForEach(fakedPages) { Page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(Page.id.uuidString)
                    // Calculating Entire Pafe Scroll Offset
                        .offsetX(currentPage == Page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(Page)))
                            // Converting page Offset into progress
                            let pageProgress = pageOffset / size.width
                            // Infinite Carousel Logic
                            if -pageProgress < 1.0 {
                                // Moving to the Last Page
                                // Which is Actually the First Duplicated Page
                                // Safe Check
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                // Moving to the First Page
                                // Which is Actually the Last Duplicated Page
                                // Safe Check
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }

                            }
                        }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        // Creating some sample tab's
        .onAppear {
            guard fakedPages.isEmpty else { return }
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(.init(color: color))
            }

            fakedPages.append(contentsOf: listOfPages)

            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                // Updating Id
                // since we are reinserting the same item into the page tabview, each view in swiftui needs to have a specific if. otherwise, the layout will not be properly rendered.
                firstPage.id = .init()
                lastPage.id = .init()

                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }

    func fakeIndex(_ of: Page) -> Int {
        fakedPages.firstIndex(of: of) ?? 0
    }

    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
