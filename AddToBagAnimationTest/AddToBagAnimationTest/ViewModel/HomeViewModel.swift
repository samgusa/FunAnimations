//
//  HomeViewModel.swift
//  AddToBagAnimationTest
//
//  Created by Sam Greenhill on 6/11/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var showCart = false
    @Published var selectedSize = ""

    // Animation Properties...
    @Published var startAnimation = false
    @Published var shoeAnimation = false

    @Published var showBag = false
    @Published var saveCart = false

    @Published var addItemToCart = false

    @Published var endAnimation = false

    // Cart Items...
    @Published var cartItems = 0

    // performing Animations

    func performAnimations() {
        withAnimation(.easeOut(duration: 0.8)) {
            shoeAnimation.toggle()
        }

        // chain Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut) {
                self.showBag.toggle()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.saveCart.toggle()
            }
        }
        // 0.75 + 0.5 = 1.25
        // because to start animation before the shoe comes to cart...
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.addItemToCart.toggle()
        }

        // End animation will start at 1.25
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.endAnimation.toggle()
            }
        }
    }

    func resetAll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[self] in
            withAnimation {
                showCart.toggle()
            }
            startAnimation = false
            endAnimation = false
            selectedSize = ""
            addItemToCart = false
            showBag = false
            saveCart = false
            cartItems += 1
        }
    }
}

