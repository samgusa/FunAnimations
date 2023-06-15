//
//  ContentView.swift
//  ShimmerTest
//
//  Created by Sam Greenhill on 5/2/23.
//

import SwiftUI

struct ContentView: View {


    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("test")
                //.navigationBarItems(trailing:
//                 Button {
//                    for i in 1...5 {
//                        self.data.append("Animal\(i)")
//                    }
//                } label: {
//                    Image(systemName: "plus")
//                        .resizable()
//                        .frame(width: 18, height: 18)
//                        .foregroundColor(.blue)
//                })
        }

    }
}

struct Home: View {
    @State var data: [String] = []

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0...10, id: \.self) { _ in
                    CardShimmer()
                }
            }
            
        }
    }
}

struct TestShimmer: View {
    @State var show = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ZStack {
                Text("Kavsoft")
                    .foregroundColor(Color.white.opacity(0.4))
                    .font(.system(size: 40))
                Text("Kavsoft")
                    .foregroundColor(Color.white)
                    .font(.system(size: 40))
                    .mask(
                        Capsule()
                            .fill(LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom))
                            .rotationEffect(.init(degrees: 30))
                            .offset(x: self.show ? 180 : -130)
                    )
            }
        }
        .onAppear {
            withAnimation(Animation.default.speed(0.1).delay(0)
                .repeatForever(autoreverses: false)) {
                self.show.toggle()
            }
        }
    }
}

struct CardShimmer: View {

    @State var show: Bool = false
    var center = (UIScreen.main.bounds.width / 2) + 110

    var body: some View {
        ZStack {
            Color.black.opacity(0.09)
                .frame(height: 200)
                .cornerRadius(10)

            Color.white
                .frame(height: 200)
                .cornerRadius(10)
                .mask(
                    Rectangle()
                    // For Some more nice effects, we will use Gradient
                        .fill(
                            // You can use any Color here
                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(Angle(degrees: 70))
                        .padding(20)
                    // Moving View continuosly so it will create Shimmer Effect
                        .offset(x: -250)
                        .offset(x: show ? 500 : 0)
                )
                .onAppear(perform: {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                        self.show.toggle()
                    }
                })
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
