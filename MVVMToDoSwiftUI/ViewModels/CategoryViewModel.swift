//
//  CategoryViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import Foundation
import SwiftData
import SwiftUI

enum CategoryFormValidationError: LocalizedError {
    case empty
    case alreadyAdded
    
    public var errorDescription: String {
        switch self {
        case .empty: String(localized: "empty_category_name")
        case .alreadyAdded: String(localized: "already_added_category")
        }
    }
}

@Observable final class CategoryViewModel {
    var modelContext: ModelContext?
    var newCategory: Category = .init(id: UUID(), name: "", containerColor: .red)
    var categories = [Category]()
    var todoViewModel: TodoViewModel?
    var isLoading = false
    
    init(_ todoViewModel: TodoViewModel? = nil, modelContext: ModelContext? = nil) {
        self.todoViewModel = todoViewModel
        self.modelContext = modelContext
    }
    
    func addCategory() throws {
        guard !newCategory.name.isEmpty else { throw CategoryFormValidationError.empty }
        guard !categories.contains(where: { $0.name == newCategory.name && $0.containerColor == newCategory.containerColor }) else { throw CategoryFormValidationError.alreadyAdded }
        modelContext?.insert(newCategory)
        
        try? modelContext?.save()
        fetchCategories()
    }
    
    func updateCategory(_ category: Category) throws {
        try modelContext?.save()
    }
    
    func deleteCategory(_ category: Category) throws {
        guard let todoViewModel else { return }
        
        for todo in todoViewModel.onProgressTodos + todoViewModel.completedTodos {
            if todo.category?.id == category.id {
                todo.category = nil
            }
        }
        
        modelContext?.delete(category)
        try modelContext?.save()
        todoViewModel.fetchTodos()
    }
    
    func fetchCategories() {
        isLoading = true

        let fetchDescriptor = FetchDescriptor<Category>()
     
        do {
            categories = try modelContext?.fetch(fetchDescriptor) ?? []
          
        } catch {}
        
        isLoading = false
    }
}
