//
//  ContentView.swift
//  InfiniteCarousel
//
//  Created by Sam Greenhill on 7/17/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Infinite Carousel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
