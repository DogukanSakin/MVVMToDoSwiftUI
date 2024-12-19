//
//  AllTodosView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 19.12.2024.
//

import SwiftUI

struct AllTodosView: View {
    @State private var navigationPath: NavigationPath = .init()
    
    // MARK: - Props
    
    var listType: TodoListType = .onProgress
    
    // MARK: - Environments
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    @Environment(CategoryViewModel.self) private var categoryViewModel: CategoryViewModel
    
    // MARK: - States
    
    @State private var todoFormNavigation = NavigationState<TodoFormNavigationParams>(params: .defaultParams)
    
    // MARK: - Render
    
    var body: some View {
        if todoViewModel.isLoading || categoryViewModel.isLoading {
            ZStack {
                Color.background
                    .ignoresSafeArea(.all)
                
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
            
        } else {
            ZStack {
                Color.background
                    .ignoresSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    ForEach(listType == .completed ? todoViewModel.completedTodos : todoViewModel.onProgressTodos, id: \.id) { todo in
                        LazyVStack {
                            TodoCard(todo: todo, width: UIScreen.main.bounds.width - 32, listType: listType) { todo in
                                todoFormNavigation.params?.selectedTodo = todo
                                todoFormNavigation.isVisible = true
                            }
                            .environment(todoViewModel)
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .task {
                todoViewModel.fetchTodos()
                categoryViewModel.fetchCategories()
            }
            .navigationDestination(isPresented: $todoFormNavigation.isVisible) {
                if let todo = todoFormNavigation.params?.selectedTodo {
                    TodoFormView(isPresentShowing: $todoFormNavigation.isVisible, todo: todo, actionType: .edit)
                        .environment(categoryViewModel)
                        .environment(todoViewModel)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(TodoItem.self, Category.self)
    
    preview.addExamples(TodoItem.samples)
    preview.addExamples(Category.samples)
    
    let todoViewModel = TodoViewModel(modelContext: preview.container.mainContext)
    let categoryViewModel = CategoryViewModel(todoViewModel, modelContext: preview.container.mainContext)
    
    return AllTodosView()
        .environment(todoViewModel)
        .environment(categoryViewModel)
        .modelContainer(preview.container)
}
