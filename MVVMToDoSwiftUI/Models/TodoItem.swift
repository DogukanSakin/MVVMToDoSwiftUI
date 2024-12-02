//
//  TodoItem.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation

struct TodoItem: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var description: String?
    var category: Category?
}
