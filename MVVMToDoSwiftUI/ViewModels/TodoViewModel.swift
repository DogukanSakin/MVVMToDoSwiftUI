//
//  TodoViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation
import SwiftData
import SwiftUI

enum TodoListType {
    case onProgress
    case completed
}

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
    var isLoading: Bool = false
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func addTodo() throws {
        guard !newTodo.title.isEmpty else { throw TodoFormValidationError.empty }
        modelContext?.insert(newTodo)
        try? modelContext?.save()
        newTodo = TodoItem(id: UUID(), title: "", date: .now)
        fetchTodos()
    }
    
    func updateTodo(_ todo: TodoItem) throws {
        try modelContext?.save()
    }
    
    func fetchTodos() {
        isLoading = true
        
        let onProgressFetchDescriptor = FetchDescriptor<TodoItem>(
            predicate: #Predicate {
                $0.isDone == false
            },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        let completedFetchDescriptor = FetchDescriptor<TodoItem>(
            predicate: #Predicate {
                $0.isDone == true
            },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        do {
            onProgressTodos = try modelContext?.fetch(onProgressFetchDescriptor) ?? []
            completedTodos = try modelContext?.fetch(completedFetchDescriptor) ?? []
        
        } catch {
            print("Error fetching todos: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func deleteTodo(_ todo: TodoItem) throws {
        modelContext?.delete(todo)
     
        do {
            try modelContext?.save()
        } catch {}
    }
    
    func changeTodoCompleteStatus(todo: TodoItem) throws {
        let completedTodo = todo
        completedTodo.isDone = !todo.isDone
        
        if completedTodo.isDone {
            completedTodos.insert(completedTodo, at: 0)
            onProgressTodos.removeAll(where: { $0.id == todo.id })
        } else {
            onProgressTodos.insert(completedTodo, at: 0)
            completedTodos.removeAll(where: { $0.id == todo.id })
        }
        
        do {
            try modelContext?.save()
        } catch {
            print("Error saving todo: \(error.localizedDescription)")
        }
    }
}
