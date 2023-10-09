//
//  ContentView.swift
//  GridTest
//
//  Created by Sam Greenhill on 10/8/23.
//

import SwiftUI

struct ContentView: View {

    // View Properties
    @State private var colors: [Color] = [.red, .blue, .purple, .yellow, .black, .indigo, .cyan, .brown, .mint, .orange]
    @State private var draggingItem: Color?

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 3)
                LazyVGrid(columns: columns, spacing: 10, content: {
                    ForEach(colors, id: \.self) { color in
                        GeometryReader {
                            let size = $0.size
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient)
                            // You can pass any item that conforms to the transferable protocol, such as a string, Data, image (SwiftUI), etc, in the draggable Modifier.
                            // Drag
                                .draggable(color) {
                                    // Custom Preview View
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: size.width, height: size.height)
                                        .onAppear {
                                            draggingItem = color
                                        }
                                }
                            // Drop
                            /// With the new DropDestination modifier, we can identify whether there is any file dropped on this view, and it also provides a callback when teh target view is being targeted for the drop
                                .dropDestination(for: Color.self) { items, location in
                                    // the action callback wont be called b/c, since in the isTarget callback we're moving the view forth and between, there are no views at the drop point, and this it wont be called
                                    draggingItem = nil
                                    return false
                                } isTargeted: { status in
                                    if let draggingItem, status, draggingItem != color {
                                        // Moving Color from source to destination
                                        if let sourceIndex = colors.firstIndex(of: draggingItem),
                                           let destinationIndex = colors.firstIndex(of: color) {
                                            withAnimation(.bouncy) {
                                                let sourceItem = colors.remove(at: sourceIndex)
                                                colors.insert(sourceItem, at: destinationIndex)
                                            }
                                        }
                                    }
                                }
                        }
                        .frame(height: 100)
                    }
                })
                .padding(15)
            }
            .navigationTitle("Movable Grid")
        }
    }
}

#Preview {
    ContentView()
}
