//
//  AddTodoView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct AddTodoView: View {
    @EnvironmentObject var todoViewModel: TodoViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    
    @Binding var isPresentShowing: Bool
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 24) {
                VStack(alignment: .leading){
                    AppInput(placeholderLocalizedValue: "todo_title", text: Binding(
                        get:{todoViewModel.newTodo.title},
                        set:{todoViewModel.newTodo.title = $0}
                    ))
                    
                    AppInput(placeholderLocalizedValue: "todo_description", isTextArea: true,text: Binding(
                        get:{todoViewModel.newTodo.description ?? ""},
                        set:{todoViewModel.newTodo.description = $0}
                    )).padding(.top)
                    
                    DatePicker(selection:  Binding(
                        get:{todoViewModel.newTodo.date},
                        set:{todoViewModel.newTodo.date = $0}
                    )) {
                        Text(String(localized: "todo_date"))
                            .font(.headline)
                            .foregroundColor(.gray)
                    }.padding(.top)
                    
                    Text(String(localized: "todo_category"))
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categoryViewModel.categories.indices, id: \.self){ index in
                                CategoryCard(category: categoryViewModel.categories[index])
                                    .padding(.horizontal, (index != 0 && index != todoViewModel.onProgressTodos.count - 1) ? 4 : 0)
                            }
                        }
                    }
                    .padding(.top)
                    
                    
                    
                    Spacer()
                    
                    
                    
                    AppButton(label: String(localized: "add_new_todo"),action:{
                        
                        
                    } ).padding(.top)
                    
                }
            }.padding()
            
            
        }
    }
}

#Preview {
    AddTodoView(isPresentShowing: .constant(true))
        .environmentObject(TodoViewModel())
        .environmentObject(CategoryViewModel())
}
