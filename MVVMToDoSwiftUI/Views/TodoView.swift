//
//  TodoView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftData
import SwiftUI

struct TodoView: View {
    // MARK: - Data Slice Prop
    
    private let DATA_SLICE_SIZE: Int = 5
    
    // MARK: - States
    
    @State private var todoViewModel: TodoViewModel
    @State private var categoryViewModel: CategoryViewModel
    @State private var showingPlusSheet = false
    @State private var categoryFormNavigation = NavigationState<CategoryFormNavigationParams>(params: .defaultParams)
    @State private var todoFormNavigation = NavigationState<TodoFormNavigationParams>(params: .defaultParams)
    @State private var viewAllNavigation = NavigationState<ViewAllNavigationParams>(params: .category)
    
    init(context: ModelContext? = nil) {
        let todoViewModel = TodoViewModel(modelContext: context)
        let categoryViewModel = CategoryViewModel(todoViewModel, modelContext: context)
        _categoryViewModel = State(initialValue: categoryViewModel)
        _todoViewModel = State(initialValue: todoViewModel)
    }
    
    // MARK: - Render
    
    var body: some View {
        NavigationStack {
            // MARK: - Loading State
            
            if todoViewModel.isLoading || categoryViewModel.isLoading {
                ZStack {
                    Color.background
                        .ignoresSafeArea(.all)
                    
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
                
            } else {
                ZStack(alignment: .bottomTrailing) {
                    Color.background
                        .ignoresSafeArea(.all)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            BaseHeader().padding(.horizontal).environment(todoViewModel)
                            
                            // MARK: - On Progress List
                            
                            if !todoViewModel.onProgressTodos.isEmpty {
                                SectionHeader(titleKey: "tasks_waiting", count: todoViewModel.onProgressTodos.count, viewAllType: .todo(.onProgress), navigation: $viewAllNavigation)
                                    .padding(.bottom)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        let todos = Array(todoViewModel.onProgressTodos.suffix(DATA_SLICE_SIZE))
                                        
                                        ForEach(todos.indices, id: \.self) { index in
                                            if index < todos.count {
                                                TodoCard(todo: todos[index], listType: .onProgress) {
                                                    todo in
                                                    todoFormNavigation.params?.selectedTodo = todo
                                                    todoFormNavigation.isVisible = true
                                                }
                                                .padding(.leading, index == 0 ? 16 : 0)
                                                .padding(.trailing, index == todos.count - 1 ? 16 : 0)
                                                .padding(.horizontal, (index != 0 && index != todos.count - 1) ? 4 : 0)
                                                .onTapGesture {
                                                    withAnimation {
                                                        do {
                                                            try todoViewModel.changeTodoCompleteStatus(todo: todos[index])
                                                        } catch {}
                                                    }
                                                }
                                                .environment(todoViewModel)
                                            }
                                        }
                                    }
                                }
                            } else if todoViewModel.onProgressTodos.isEmpty, todoViewModel.completedTodos.isEmpty {
                                Image("WelcomeImage")
                                    .resizable()
                                    .frame(width: 325, height: 325)
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                
                                Text(String(localized: "empty_list"))
                                    .font(.regular(size: 14))
                                    .padding(.top)
                            }
                            
                            // MARK: - Categories List
                            
                            if !categoryViewModel.categories.isEmpty {
                                SectionHeader(titleKey: "categories", viewAllType: .category, navigation: $viewAllNavigation)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(categoryViewModel.categories.indices, id: \.self) { index in
                                            if index < categoryViewModel.categories.count {
                                                CategoryCard(category: categoryViewModel.categories[index]) {
                                                    category in
                                                    categoryFormNavigation.params?.selectedCategory = category
                                                    categoryFormNavigation.isVisible = true
                                                }
                                                .padding(.horizontal, (index != 0 && index != categoryViewModel.categories.count - 1) ? 4 : 0)
                                                .environment(categoryViewModel)
                                            }
                                        }
                                    }.padding(.horizontal)
                                }
                                .padding(.vertical)
                            }
                            
                            // MARK: - Completed List
                            
                            if !todoViewModel.completedTodos.isEmpty {
                                SectionHeader(titleKey: "completed", count: todoViewModel.completedTodos.count, viewAllType: .todo(.completed), navigation: $viewAllNavigation)
                                
                                ScrollView(showsIndicators: false) {
                                    ForEach(Array(todoViewModel.completedTodos).suffix(DATA_SLICE_SIZE), id: \.id) { todo in
                                        VStack {
                                            TodoCard(todo: todo, width: UIScreen.main.bounds.width - 32, listType: .completed) {
                                                todo in
                                                todoFormNavigation.params?.selectedTodo = todo
                                                todoFormNavigation.isVisible = true
                                            }
                                            .onTapGesture {
                                                withAnimation {
                                                    do {
                                                        try todoViewModel.changeTodoCompleteStatus(todo: todo)
                                                    } catch {}
                                                }
                                            }
                                            .environment(todoViewModel)
                                        }
                                    }
                                }
                                .padding()
                            }
                            
                            Spacer()
                        }
                    }
                    
                    FloatingButton(action: {
                        showingPlusSheet.toggle()
                    })
                    .padding()
                    
                }.sheet(isPresented: $showingPlusSheet) {
                    PlusSheetView(isPresentShowing: $showingPlusSheet)
                        .environment(categoryViewModel)
                        .environment(todoViewModel)
                }.task {
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
                .navigationDestination(isPresented: $categoryFormNavigation.isVisible) {
                    if let category = categoryFormNavigation.params?.selectedCategory {
                        CategoryFormView(isPresentShowing: $categoryFormNavigation.isVisible, category: category, actionType: .edit)
                            .environment(categoryViewModel)
                    }
                }
                .navigationDestination(isPresented: $viewAllNavigation.isVisible) {
                    switch viewAllNavigation.params {
                    case .todo(let todoListType):
                        AllTodosView(listType: todoListType)
                            .environment(categoryViewModel)
                            .environment(todoViewModel)
                    case .category:
                        AllCategoriesView().environment(categoryViewModel)
                    case .none:
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(TodoItem.self, Category.self)
    preview.addExamples(TodoItem.samples)
    preview.addExamples(Category.samples)
    return TodoView(context: preview.container.mainContext).modelContainer(preview.container)
}
