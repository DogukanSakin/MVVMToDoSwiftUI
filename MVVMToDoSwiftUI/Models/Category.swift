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
