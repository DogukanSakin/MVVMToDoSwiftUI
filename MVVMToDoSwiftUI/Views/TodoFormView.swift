//
//  AddTodoView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

// MARK: - Todo Form Action Type

enum TodoFormActionType {
    case edit
    case add
}

// MARK: - Navigation Params

struct TodoFormNavigationParams {
    var selectedTodo: TodoItem?
    
    static var defaultParams: TodoFormNavigationParams {
        .init(selectedTodo: nil)
    }
}

struct TodoFormView: View {
    // MARK: - Environment Objects
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    @Environment(CategoryViewModel.self) private var categoryViewModel: CategoryViewModel
    
    // MARK: - Bindings
    
    @Binding var isPresentShowing: Bool
    
    // MARK: - Props
    
    var todo: TodoItem
    var actionType: TodoFormActionType = .add
    
    // MARK: - States
    
    @State private var selectedCategoryIndex: Int?
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""
    
    // MARK: - Render
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        AppInput(placeholderLocalizedValue: "todo_title", text: Binding(
                            get: { todo.title },
                            set: { todo.title = $0 }
                        ))
                        .padding([.top, .horizontal])
                        
                        AppInput(placeholderLocalizedValue: "todo_description", isTextArea: true, text: Binding(
                            get: { todo.comment ?? "" },
                            set: { todo.comment = $0 }
                        )).padding([.top, .horizontal])
                        
                        DatePicker(selection: Binding(
                            get: { todo.date },
                            set: { todo.date = $0 }
                        )) {
                            Text(String(localized: "todo_date"))
                                .font(.headline)
                                .foregroundColor(.gray)
                        }.padding()
                        
                        if !categoryViewModel.categories.isEmpty {
                            Text(String(localized: "todo_category"))
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(categoryViewModel.categories.indices, id: \.self) { index in
                                        CategoryCard(category: categoryViewModel.categories[index])
                                            .onTapGesture {
                                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                                    if selectedCategoryIndex == index {
                                                        selectedCategoryIndex = nil
                                                    } else {
                                                        selectedCategoryIndex = index
                                                    }
                                                }
                                            }
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(
                                                        selectedCategoryIndex == index ? Color.white : Color.clear,
                                                        lineWidth: 4
                                                    )
                                            )
                                            .scaleEffect(selectedCategoryIndex == index ? 1.1 : 1)
                                            .padding(.leading, index == 0 ? 16 : 0)
                                            .padding(.trailing, index == categoryViewModel.categories.count - 1 ? 16 : 0)
                                            .padding(.vertical, 12)
                                            .environment(categoryViewModel)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                        
                        Spacer()
                        
                        AppButton(label: String(localized: actionType == .add ? "add_new_todo" : "save"), action: {
                            do {
                                if let selectedCategoryIndex = selectedCategoryIndex {
                                    if actionType == .edit, let oldCategory = todo.category, let oldIndex = categoryViewModel.categories.firstIndex(of: oldCategory) {
                                        categoryViewModel.categories[oldIndex].todoItems?.removeAll { $0.id == todo.id }
                                    }
                                    
                                    todo.category = categoryViewModel.categories[selectedCategoryIndex]
                                    categoryViewModel.categories[selectedCategoryIndex].todoItems?.append(todo)
                                } else {
                                    if let oldCategory = todo.category,
                                       let oldIndex = categoryViewModel.categories.firstIndex(of: oldCategory)
                                    {
                                        categoryViewModel.categories[oldIndex].todoItems?.removeAll { $0.id == todo.id }
                                        todo.category = nil
                                    }
                                }
                                
                                actionType == .add ? try todoViewModel.addTodo() : try todoViewModel.updateTodo(todo)
                                isPresentShowing = false
                            } catch let error as TodoFormValidationError {
                                alertMessage = error.errorDescription
                                isShowAlert = true
                            } catch {}
                        }).padding()
                    }
                }
            }
        }.onAppear {
            if let categoryIndex = categoryViewModel.categories.firstIndex(where: { $0.id == todo.category?.id }) {
                selectedCategoryIndex = categoryIndex
            }
        }
    }
}

#Preview {
    TodoFormView(isPresentShowing: .constant(true), todo: TodoViewModel().newTodo)
        .environment(TodoViewModel())
        .environment(CategoryViewModel())
}
