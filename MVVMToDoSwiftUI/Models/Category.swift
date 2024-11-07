//
//  Category.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation

struct Category: Identifiable {
    var id: UUID
    var name: String
    var todoItems: [TodoItem] 
}


let categoryWork = Category(id: UUID(), name: "Work", todoItems: [])
let categoryPersonal = Category(id: UUID(), name: "Personal", todoItems: [])
let categoryShopping = Category(id: UUID(), name: "Shopping", todoItems: [])
