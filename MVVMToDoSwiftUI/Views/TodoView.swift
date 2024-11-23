//
//  TodosView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var todoViewModel = TodoViewModel()
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    @State private var showingPlusSheet = false
    
    var body: some View {
        
        ZStack(alignment:.bottomTrailing) {
            Color.background
                .ignoresSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                
                VStack{
                    Header().padding().environmentObject(todoViewModel)
                    
                    // MARK: - On Progress List
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(todoViewModel.onProgressTodos.indices, id: \.self) {  index in
                                TodoCard(todo: todoViewModel.onProgressTodos[index])
                                    .padding(.leading, index == 0 ? 16 : 0)
                                    .padding(.trailing, index == todoViewModel.onProgressTodos.count - 1 ? 16 : 0)
                                    .padding(.horizontal, (index != 0 && index != todoViewModel.onProgressTodos.count - 1) ? 4 : 0)
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    // MARK: - Categories List
                    
                    if !categoryViewModel.categories.isEmpty{
                        HStack {
                            Text(String(format: NSLocalizedString("categories", comment: ""), todoViewModel.completedTodos.count))
                                .font(.system(size: 14, weight: .regular))
                            
                            Spacer()
                            
                            Button(action:{}){
                                Text(String(localized: "view_more"))
                                    .font(.system(size: 14, weight: .regular))
                            }
                            
                            
                        }
                        .padding([.top, .horizontal])
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categoryViewModel.categories.indices, id: \.self){ index in
                                    CategoryCard(category: categoryViewModel.categories[index])
                                        .padding(.horizontal, (index != 0 && index != todoViewModel.onProgressTodos.count - 1) ? 4 : 0)
                                }
                            }.padding(.horizontal)
                        }
                        .padding(.vertical)
                    }

                    // MARK: - Completed List
                    
                    HStack {
                        Text(String(format: NSLocalizedString("completed", comment: ""), todoViewModel.completedTodos.count))
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Button(action:{}){
                            Text(String(localized: "view_more"))
                                .font(.system(size: 14, weight: .regular))
                        }
                    }
                    .padding([.top, .horizontal])
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(todoViewModel.onProgressTodos, id: \.id) { todo in
                            VStack{
                                TodoCard(todo: todo,width:.infinity)
                            }
                        }
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                }
                
            }

            FloatingButton(action: {
                showingPlusSheet.toggle()
            })
            .padding()
    
        }.sheet(isPresented: $showingPlusSheet) {
            PlusSheetView().environmentObject(categoryViewModel)
        }
    }
}

// MARK: - Header

struct Header: View {
    @EnvironmentObject var todoViewModel: TodoViewModel
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading){
                    Text(String(localized: "hello"))
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .regular))
                    
                    Text(String(format: NSLocalizedString("tasks_waiting", comment: ""), todoViewModel.onProgressTodos.count))
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

// MARK: - Plus Sheet View

struct PlusSheetView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea(.all)
            
            VStack {
                HStack{
                    TabButton(label:String(localized: "add_new_todo")  ,isSelected: selectedTab == 0){
                        selectedTab = 0
                    }
                    
                    TabButton(label:String(localized: "add_new_category")  ,isSelected: selectedTab == 1){
                        selectedTab = 1
                    }
                }
                .padding(.top)
                
                Divider()
                
                TabView(selection: $selectedTab){
                    AddTodoView().tag(0)
                    
                    AddCategoryView().tag(1)
                }
                
                Spacer()
                
            }.padding()
        }
    }
}

#Preview {
   
    TodoView().environmentObject(CategoryViewModel()).environmentObject(TodoViewModel())
}
