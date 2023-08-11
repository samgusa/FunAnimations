//
//  TabStateScrollView.swift
//  ScrollHideTest
//
//  Created by Sam Greenhill on 8/11/23.
//

import SwiftUI

// Custom View
struct TabStateScrollView<Content: View>: View {
    var axis: Axis.Set
    var showIndicator: Bool
    @Binding var tabState: Visibility
    var content: Content
    init(axis: Axis.Set, showIndicator: Bool, tabState: Binding<Visibility>, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.showIndicator = showIndicator
        self._tabState = tabState
        self.content = content()
    }

    var body: some View {
        ScrollView(axis, showsIndicators: showIndicator, content: {
            content
        })
        .scrollIndicators(showIndicator ? .visible : .hidden)
        .background {
            CustomGesture {
                handleTapState($0)
            }
        }
    }

    // Handling Tab State on Swipe
    func handleTapState(_ gesture: UIPanGestureRecognizer) {
        let offsetY = gesture.translation(in: gesture.view).y
        let velocityY = gesture.velocity(in: gesture.view).y

        // Using velocity to hide or unhide the tab bar, but you can use offset or a combination of offset and velocity to update tabState
        if velocityY < 0 {
            // Swiping Up
            if -(velocityY / 5) > 60 && tabState == .visible {
                tabState = .hidden
            }
        } else {
            // Swiping Down
            if (velocityY / 5) > 40 && tabState == .hidden {
                tabState = .visible
            }
        }
    }
}

// Adding a Custom Simultaneous UIPan Gesture to know about what direction did the user is swiping

fileprivate struct CustomGesture: UIViewRepresentable {
    var onChange: (UIPanGestureRecognizer) -> ()
    // Gesture ID
    private let gestureID = UUID().uuidString

    func makeCoordinator() -> Coordinator {
        return Coordinator(onChange: onChange)
    }

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            // uiView = UIView, 1st superview = Background {}, 2nd superview = Source View
            // Verifying if there is already any gesture is Added.
            if let superView = uiView.superview?.superview, !(superView.gestureRecognizers?.contains(where: { $0.name == gestureID}) ?? false) {
                let gesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.gestureChange(gesture:)))
                // VVV This is important because without it it wont work. We need to attacht the delegate here. it is the key part to making the gesture work simultaneously.
                // It is a must, because otherwise, multiple gestures will be added.
                gesture.name = gestureID
                gesture.delegate = context.coordinator
                // so what we're going to do is simply create a pan gesture that will work simultaneously with the scrollview, and then with the gesture translation and velocity, we can hide or unhide the tab bar.

                // Adding Gesture to the SuperView
                superView.addGestureRecognizer(gesture)
            }
        }
    }

    // Selector Class
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onChange: (UIPanGestureRecognizer) -> ()
        init(onChange: @escaping (UIPanGestureRecognizer) -> Void) {
            self.onChange = onChange
        }
        @objc
        func gestureChange(gesture: UIPanGestureRecognizer) {
            // Simply calling the onChange Callback
            onChange(gesture)
        }

        // this is important part, by enabling this, the gesture will work simultaneously with other gestures such as scrollView, etc.
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
}


struct TabStateScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
