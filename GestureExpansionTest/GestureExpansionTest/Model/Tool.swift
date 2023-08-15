//
//  Tool.swift
//  GestureExpansionTest
//
//  Created by Sam Greenhill on 8/14/23.
//

import SwiftUI

// MARK: Tool Model And Sample Tools

struct Tool: Identifiable {
    var id: String = UUID().uuidString
    var icon: String
    var name: String
    var color: Color
    var toolPosition: CGRect = .zero
}
