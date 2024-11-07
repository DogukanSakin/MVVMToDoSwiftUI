//
//  TodoCard.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 7.11.2024.
//

import SwiftUI

struct OnProgressTodoCard: View {
    let todo = TodoItem(id: UUID(), title: "Test", categories: [categoryWork])
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    OnProgressTodoCard()
}
