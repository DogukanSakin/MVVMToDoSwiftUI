//
//  TodosView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Header()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.todos, id: \.id) { todo in
                            OnProgressTodoCard(todo: todo)
                        }
                    }
                }
                .padding(.top)
                
                Spacer()
                
                HStack{
                    Text(String(format: NSLocalizedString("completed", comment: ""), 0))
                        .font(.system(size: 14, weight: .regular))
                        .padding(.top,2)
                    
                    Spacer()
                }.padding(.top)
                
              
                
                ScrollView( showsIndicators: false) {
                    ForEach(viewModel.todos, id: \.id) { todo in
                        VStack(alignment:.leading){
                            HStack{
                                Text(todo.title)
                                
                                Spacer()
                            }.padding(.top)
                         
                            
                          
                        }
                      
                    }
                    
                }
                .padding(.top)
                
            }.padding()
            
            VStack{
                Spacer()
                
                HStack {
                    Spacer()
                    
                    FloatingButton()
                }
            }
            
            
        }
    }
}

// MARK: - Header

struct Header: View {
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading){
                    Text(String(localized: "hello"))
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .regular))
                    
                    Text(String(format: NSLocalizedString("tasks_waiting", comment: ""), 0))
                        .font(.system(size: 14, weight: .regular))
                        .padding(.top,2)
                }
                
                Spacer()
                
                Button(action: {}){
                    ZStack{
                        Circle()
                            .stroke(Color.buttonCircle, lineWidth: 1)
                            .frame(width: 36,height: 36)
                        
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        
    }
}

#Preview {
    TodoView()
}
