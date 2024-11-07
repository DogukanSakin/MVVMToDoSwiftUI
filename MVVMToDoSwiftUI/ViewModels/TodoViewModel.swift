//
//  TodosViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation

class TodoViewModel:ObservableObject{
    @Published var todos: [TodoItem] = [
        TodoItem(id: UUID(), title: "Complete SwiftUI tutorial", categories: [categoryWork]),
        TodoItem(id: UUID(), title: "Buy groceries", categories: [categoryShopping]),
        TodoItem(id: UUID(), title: "Finish reading book", categories: [categoryPersonal])
    ]
}
