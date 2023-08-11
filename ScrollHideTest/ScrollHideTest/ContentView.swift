//
//  ContentView.swift
//  ScrollHideTest
//
//  Created by Sam Greenhill on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    // View Properties
    @State private var tabState: Visibility = .visible
    var body: some View {
        TabView {
            NavigationStack {
                TabStateScrollView(axis: .vertical, showIndicator: false, tabState: $tabState) {
                    // Add Scroll Content
                    VStack(spacing: 15) {
                        ForEach(1...13, id: \.self) { index in
                            GeometryReader { geometry in
                                let size = geometry.size
                                Image("Animal\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .frame(height: 200)
                        }
                    }
                    .padding(15)
                }
                .navigationTitle("Home")
            }
            .toolbar(tabState, for: .tabBar)
            // TabState must be set for each tab individually in the SwiftUI hierarchy
            .animation(.easeInOut(duration: 0.3), value: tabState)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            // Other Sample Tab's
            Text("Favorites")
                .tabItem {
                    Image(systemName: "suit.heart")
                    Text("Favorite")
                }
            Text("Notification")
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notification")
                }
            Text("Account")
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
