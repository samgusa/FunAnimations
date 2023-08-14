//
//  ContentView.swift
//  AnimatedTagsTest
//
//  Created by Sam Greenhill on 8/13/23.
//

import SwiftUI

struct ContentView: View {
    // View Properties
    // Sample Tags
    @State private var tags: [String] = ["SwiftUI", "Swift", "iOS", "Apple", "Xcode", "WWDC", "Android", "React", "Flutter", "App", "Indie", "Developer", "Objc", "C#", "C", "C++", "iPhone", "iPad", "Macbook", "iPadOS", "macOS"]

    // Selection
    @State private var selectedTags: [String] = []
    // Adding Matched Geometry Effect
    @Namespace private var animation

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(selectedTags, id: \.self) { tag in
                        TagView(tag, .pink, "checkmark")
                            .matchedGeometryEffect(id: tag, in: animation)
                            // Removing from Selected List
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedTags.removeAll(where: { $0 == tag })
                                }
                            }

                    }
                }
                .padding(.horizontal, 15)
                .frame(height: 35)
                .padding(.vertical, 15)
            }
            // only works in iOS 17
            //.scrollClipDisabled(true)
            //.scrollIndicators(.hidden)
            .overlay(content: {
                if selectedTags.isEmpty {
                    Text("Select More than 3 Tags")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            })
            .background(.white)
            .zIndex(1)
            ScrollView(.vertical) {
                TagLayout(alignment: .leading, spacing: 10) {
                    ForEach(tags.filter { !selectedTags.contains($0) }, id: \.self) { tag in
                        TagView(tag, .blue, "plus")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedTags.insert(tag, at: 0)
                                }
                            }
                    }
                }
                // when adding the padding, the view's alignment is changed because of the difference in the view bounds in the layout API. 
                .padding(15)
            }
            // only works in iOS 17
            //.scrollClipDisabled(true)
            //.scrollIndicators(.hidden)
            .background(.black.opacity(0.05))
            .zIndex(0)
            ZStack {
                Button(action: {}, label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.pink.gradient)
                        }
                })
                // Disabling until 3 or more tags selected
                .disabled(selectedTags.count < 3)
                .opacity(selectedTags.count < 3 ? 0.5 : 1)
                .padding()
            }
            .background(.white)
            .zIndex(2)
        }
        .preferredColorScheme(.light)
    }

    // Tag View
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color, _ icon: String) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)

            Image(systemName: icon)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(color.gradient)
        }
    }



}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
