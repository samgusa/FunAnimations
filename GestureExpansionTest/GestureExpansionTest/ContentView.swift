//
//  ContentView.swift
//  GestureExpansionTest
//
//  Created by Sam Greenhill on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Toolbar Animation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
