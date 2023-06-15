//
//  ContentLoader.swift
//  ShimmerTest
//
//  Created by Sam Greenhill on 5/2/23.
//

import SwiftUI

struct ContentLoader: View {
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 2) {
                Circle()
                    .frame(width: 50, height: 50)
                Rectangle()
                    .frame(height: 200)
                    .padding(.horizontal)
            }
            .addShimmerModifier()
        }
    }
}

struct ContentLoader_Previews: PreviewProvider {
    static var previews: some View {
        ContentLoader()
    }
}

extension View {
    func addShimmerModifier() -> some View {
        modifier(ShimmerViewModifier())
    }
}
