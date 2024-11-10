//
//  Category.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation
import SwiftUI

struct Category: Identifiable {
    var id: UUID
    var name: String
    var color: Color
    var todoItems: [TodoItem]?
}


let categoryWork = Category(id: UUID(), name: "Work",color: .red, todoItems: [])
let categoryPersonal = Category(id: UUID(), name: "Personal", color: .blue, todoItems: [])
let categoryShopping = Category(id: UUID(), name: "Shopping", color: .green, todoItems: [])
