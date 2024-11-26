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
    var containerColor: Color
    var labelColor: Color = .black
    var todoItems: [TodoItem]?
}


let categoryWork = Category(id: UUID(), name: "Work",containerColor: .red, todoItems: [])
let categoryPersonal = Category(id: UUID(), name: "Personal", containerColor: .blue, todoItems: [])
let categoryShopping = Category(id: UUID(), name: "Shopping", containerColor: .green, todoItems: [])
