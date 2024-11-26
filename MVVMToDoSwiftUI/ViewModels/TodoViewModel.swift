//
//  TodosViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation

class TodoViewModel:ObservableObject{
    @Published var newTodo = TodoItem(id: UUID(), title: "", date: .now)
    
    @Published var onProgressTodos: [TodoItem] = [
        TodoItem(id: UUID(), title: "Complete SwiftUI tutorial",date: .now, category: categoryWork),
        TodoItem(id: UUID(), title: "Buy groceries", date: .now,category: categoryShopping),
        TodoItem(id: UUID(), title: "Finish reading book", date: .now,category: categoryPersonal)
    ]
    
    @Published var completedTodos: [TodoItem] = [
        TodoItem(id: UUID(), title: "Complete SwiftUI tutorial",date: .now, category: categoryWork),
        TodoItem(id: UUID(), title: "Buy groceries", date: .now,category: categoryShopping),
        TodoItem(id: UUID(), title: "Finish reading book", date: .now,category: categoryPersonal)
    ]
    
    
}
