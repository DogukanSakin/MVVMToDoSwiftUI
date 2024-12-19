//
//  TodoSamples.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 12.12.2024.
//

import Foundation

extension TodoItem {
    static var samples: [TodoItem] {
        [
            TodoItem(id: UUID(), title: "First Todo", date: .now, isDone: true),
            TodoItem(id: UUID(), title: "Second Todo", date: .now, isDone: false),
            TodoItem(id: UUID(), title: "Third Todo", date: .now, isDone: false),
        ]
    }
}
