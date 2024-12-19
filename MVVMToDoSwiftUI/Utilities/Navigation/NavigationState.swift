//
//  Navigable.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 19.12.2024.
//

import Foundation

struct NavigationState<Element> {
    var id = UUID()
    var params: Element? = nil
    var isVisible: Bool = false
}
