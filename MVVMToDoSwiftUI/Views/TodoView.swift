//
//  TodosView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var showingPlusSheet = false
    
    var body: some View {
        
        ZStack {
            Color.background
                .ignoresSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                
                VStack{
                    Header().padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.onProgressTodos.indices, id: \.self) {  index in
                                OnProgressTodoCard(todo: viewModel.onProgressTodos[index])
                                    .padding(.leading, index == 0 ? 16 : 0)
                                    .padding(.trailing, index == viewModel.onProgressTodos.count - 1 ? 16 : 0)
                                    .padding(.horizontal, (index != 0 && index != viewModel.onProgressTodos.count - 1) ? 4 : 0)
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                    
                    HStack {
                        Text(String(format: NSLocalizedString("completed", comment: ""), viewModel.completedTodos.count))
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Button(action:{}){
                            Text(String(localized: "view_more"))
                                .font(.system(size: 14, weight: .regular))
                        }
                        
                        
                    }
                    .padding([.top, .horizontal])
                    
                    ScrollView( showsIndicators: false) {
                        ForEach(viewModel.onProgressTodos, id: \.id) { todo in
                            VStack(alignment:.leading){
                                CompletedTodoCard(todo: todo)
                                
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                    FloatingButton(action: {
                        showingPlusSheet.toggle()
                    })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                
            }
        }.sheet(isPresented: $showingPlusSheet) {
            PlusSheetView()
        }
    }
}

// MARK: - Header

struct Header: View {
    @StateObject private var viewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading){
                    Text(String(localized: "hello"))
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .regular))
                    
                    Text(String(format: NSLocalizedString("tasks_waiting", comment: ""), viewModel.onProgressTodos.count))
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
    TodoView()
}
