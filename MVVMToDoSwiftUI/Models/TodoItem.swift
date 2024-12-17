//
//  TodoItem.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation
import SwiftData

@Model
final class TodoItem: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var comment: String?
    var category: Category?
    var isDone: Bool = false
    
    init(id: UUID, title: String, date: Date, comment: String? = nil, category: Category? = nil,isDone: Bool = false) {
        self.id = id
        self.title = title
        self.date = date
        self.comment = comment
        self.category = category
        self.isDone = isDone
    }
}



