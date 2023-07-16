//
//  MorphingView.swift
//  ShapeMorphingTest
//
//  Created by Sam Greenhill on 7/16/23.
//

import SwiftUI

struct MorphingView: View {
    // MARK: View Properties
    @State var currentImage: CustomShape = .cloud
    @State var pickerImage: CustomShape = .cloud
    @State var turnOffImageMorph: Bool = false
    @State var blurRadius: CGFloat = 0
    @State var animateMorph: Bool = false
    var body: some View {
        VStack {
            // MARK: Image Morph is Simple
            // Simply Mask the Canvas Shape as Image Mask
            GeometryReader { proxy in
                let size = proxy.size
                Image("Puppy")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: 105, y: 65)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay(content: {
                        Rectangle()
                            .fill(.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask {
                        // MARK: Morphing Shapes with the help of Canvas and Filters
                        Canvas { context, size in
                            // MARK: Morphing Filters
                            // MARK: For More Morph Shape Link Change This
                            context.addFilter(.alphaThreshold(min: 0.3))
                            // MARK: this value plays major role in the Morphing Animation
                            // MARK: For Reverse Animation
                            // Until 20 -> it will be like 0-1
                            // After 20 Til 40 -> It will be like 1-0
                            context.addFilter(.blur(radius: blurRadius >= 20 ? 20 - (blurRadius - 20) : blurRadius))

                            // MARK: Draw inside Layer
                            context.drawLayer { ctx in
                                if let resolvedImage = context.resolveSymbol(id: 1) {
                                    ctx.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)
                                }
                            }

                        } symbols: {
                            // MARK: Giving Images with ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                        // MARK: Animations will not work in the Canvas
                        // We can use Timeline View for those Animations
                        // but here I'm going to simply use Timer to Acheive the same effect
                        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                            if animateMorph {
                                if blurRadius <= 40 {
                                    // the timer count is actually employed to increase speed. As an illustration, choose 0.007 for the ideal animation speed
                                    // this is Animation speed
                                    // you can change this for your Own
                                    blurRadius += 0.5
                                    if blurRadius.rounded() == 20 {
                                        // MARK: Change of Next Image Goes Here
                                        currentImage = pickerImage
                                    }
                                }

                                if blurRadius.rounded() == 40 {
                                    // MARK: End Animation and Reset the Blur Radius to Zero
                                    animateMorph = false
                                    blurRadius = 0
                                }
                            }
                        }
                    }
            }
            .frame(height: 400)

            // MARK: Segmented Picker

            Picker("", selection: $pickerImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            // MARK: Avoid Tap until the current Animation is Finished
            .overlay(content: {
                Rectangle()
                    .fill(.primary)
                    .opacity(animateMorph ? 0.05 : 0)
            })
            .padding(15)
            .padding(.top, -50)
            // MARK: When ever Picker Image Changes
            // Morphing Into New Shape
            .onChange(of: pickerImage) { newValue in
                animateMorph = true
            }

            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.top, 10)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
    }

}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8), value: currentImage)
            .frame(width: 300, height: 300)
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
