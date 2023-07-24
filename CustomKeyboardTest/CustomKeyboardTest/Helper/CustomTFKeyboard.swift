//
//  CustomTFKeyboard.swift
//  CustomKeyboardTest
//
//  Created by Sam Greenhill on 7/24/23.
//

import SwiftUI
import UIKit

// Custom Textfield Keyboard TextField Modifier
extension TextField {
    @ViewBuilder
    func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .background {
                SetTFKeyboard(keyboardContent: content())
            }
    }
}

fileprivate struct SetTFKeyboard<Content: View>: UIViewRepresentable {
    var keyboardContent: Content
    @State private var hostingController: UIHostingController<Content>?

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let textfieldContainerView = uiView.superview?.superview {
                if let textField = textfieldContainerView.findTextField {
                    // if the inpur is already set, then updating it's content
                    if textField.inputView == nil {
                        // Now with the help of UIHosting Controller converting SwiftUI view into UIKit View
                        hostingController = UIHostingController(rootView: keyboardContent)
                        hostingController?.view.frame = .init(origin: .zero, size: hostingController?.view.intrinsicContentSize ?? .zero)
                        // Setting TF's input view as our SwiftUI View
                        textField.inputView = hostingController?.view
                    } else {
                        // updating hosting content
                        hostingController?.rootView = keyboardContent
                    }
                } else {
                    print("Failed to find TF")
                }
            }
        }
    }

}

struct CustomTFKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Extracting Textfield from the Subviews
// instead of utilizing indices like subviews[0] in that manner, we can simply combine all the subviews into a single array and find the text field that is inside the container

fileprivate extension UIView {
    var allSubviews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }

    // Finding the UIView is Textfield or Not
    var findTextField: UITextField? {
        if let textField = allSubviews.first(where: { view in
            view is UITextField
        }) as? UITextField {
            return textField
        }
        return nil
    }
}
