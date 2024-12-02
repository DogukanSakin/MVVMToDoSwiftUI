//
//  AddTodoView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - Environment Objects

    @EnvironmentObject var todoViewModel: TodoViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel

    // MARK: - Bindings

    @Binding var isPresentShowing: Bool

    // MARK: - States

    @State private var selectedCategoryIndex: Int?
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        AppInput(placeholderLocalizedValue: "todo_title", text: Binding(
                            get: { todoViewModel.newTodo.title },
                            set: { todoViewModel.newTodo.title = $0 }
                        ))
                        .padding([.top, .horizontal])

                        AppInput(placeholderLocalizedValue: "todo_description", isTextArea: true, text: Binding(
                            get: { todoViewModel.newTodo.description ?? "" },
                            set: { todoViewModel.newTodo.description = $0 }
                        )).padding([.top, .horizontal])

                        DatePicker(selection: Binding(
                            get: { todoViewModel.newTodo.date },
                            set: { todoViewModel.newTodo.date = $0 }
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
                                HStack {
                                    ForEach(categoryViewModel.categories.indices, id: \.self) { index in
                                        CategoryCard(category: categoryViewModel.categories[index])
                                            .onTapGesture {
                                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                                    if selectedCategoryIndex == index {
                                                        selectedCategoryIndex = nil
                                                        todoViewModel.newTodo.category = nil
                                                    } else {
                                                        selectedCategoryIndex = index
                                                        todoViewModel.newTodo.category = categoryViewModel.categories[index]
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
                                            .padding(.horizontal, (index != 0 && index != todoViewModel.onProgressTodos.count - 1) ? 8 : 0)
                                            .padding(.vertical, 12)
                                    }
                                }
                            }
                            .padding(.top)
                        }

                        Spacer()

                        AppButton(label: String(localized: "add_new_todo"), action: {
                            do {
                                try todoViewModel.addTodo()
                                isPresentShowing = false
                            } catch let error as CategoryFormValidationError {
                                alertMessage = error.errorDescription
                                isShowAlert = true
                            } catch {}
                        }).padding()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTodoView(isPresentShowing: .constant(true))
        .environmentObject(TodoViewModel())
        .environmentObject(CategoryViewModel())
}
