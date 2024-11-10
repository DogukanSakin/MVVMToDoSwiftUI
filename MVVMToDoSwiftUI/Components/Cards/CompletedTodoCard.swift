//
//  CompletedTodoCard.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 9.11.2024.
//

import SwiftUI

struct CompletedTodoCard: View {
    let todo:TodoItem
    
    var body: some View {
        ZStack{
            Color.white
            
            HStack {
                if let todoCategory = todo.category {
                    Rectangle()
                        .fill(todoCategory.color)
                        .frame(width: 4)
                        .padding(.trailing)
                }
              
                
                VStack(alignment: .leading){
                    Text(todo.title)
                        .font(.semiBold(size: 16))
                        .lineLimit(1)
                    
                    if todo.description != nil {
                        Text(todo.description!)
                            .font(.regular(size: 12))
                            .lineLimit(2)
                            .foregroundStyle(.gray)
                            .padding(.top,1)
                    }
                    
                    Spacer()
                    
                    Text("\(todo.date, formatter: Formatter.dateFormatter)")
                        .font(.regular(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.top,1)
                    
                    Spacer()
                    
                }.padding(.top)
                
                Spacer()
                
               
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(todo.category?.color ?? .green)
                    .font(.system(size: 24))
                    .padding(.trailing)
                
            }
            
            
            
            
        }
        .frame(height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ZStack{
        Color.background.edgesIgnoringSafeArea(.all)
        
        CompletedTodoCard(todo: TodoItem(id: UUID(), title: "Test", date: .now, description: "Lorem ipsum", category: categoryWork))
    }
}

