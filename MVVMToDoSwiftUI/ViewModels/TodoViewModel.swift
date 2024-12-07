//
//  TodoViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation
import SwiftData
import SwiftUI

enum TodoFormValidationError: LocalizedError {
    case empty
    
    public var errorDescription: String {
        switch self {
        case .empty: String(localized: "empty_category_name")
        }
    }
}

@Observable class TodoViewModel {
    var modelContext: ModelContext?
    var newTodo = TodoItem(id: UUID(), title: "", date: .now)
    var onProgressTodos = [TodoItem]()
    var completedTodos = [TodoItem]()
    
    func addTodo() throws {
        guard !newTodo.title.isEmpty else { throw TodoFormValidationError.empty }
        modelContext?.insert(newTodo)
        try? modelContext?.save()
        fetchTodos()
    }
    
    func fetchTodos() {
        let onProgressFetchDescriptor = FetchDescriptor<TodoItem>(
            predicate: #Predicate {
                $0.isDone == false
            }
        )
        
        let completedFetchDescriptor = FetchDescriptor<TodoItem>(
            predicate: #Predicate {
                $0.isDone == true
            }
        )
        
        do {
            onProgressTodos = try modelContext?.fetch(onProgressFetchDescriptor) ?? []
            completedTodos = try modelContext?.fetch(completedFetchDescriptor) ?? []
        } catch {
            print("Error fetching todos: \(error.localizedDescription)")
        }
    }
}
