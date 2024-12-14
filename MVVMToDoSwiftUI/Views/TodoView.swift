//
//  TodoView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftData
import SwiftUI

// MARK: - Navigation Props

struct TodoEditNavigationState {
    var selectedTodo: TodoItem?
    var isVisible: Bool
}

struct TodoView: View {
    private let DATA_SLICE_SIZE: Int = 5
    
    // MARK: - Data Context
    
    @Environment(\.modelContext) var context
    
    // MARK: - States
    
    @State private var todoViewModel = TodoViewModel()
    @State private var categoryViewModel = CategoryViewModel()
    @State private var showingPlusSheet = false
    @State private var todoEditNavigation = TodoEditNavigationState(selectedTodo: nil, isVisible: false)

    
    // MARK: - Formatted Data Arrays
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.background
                    .ignoresSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Header().padding().environment(todoViewModel)
                        
                        // MARK: - On Progress List
                        
                        if !todoViewModel.onProgressTodos.isEmpty {
                            SectionHeader(titleKey: "tasks_waiting", count: todoViewModel.onProgressTodos.count)
                                .padding(.bottom)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    let todos = Array(todoViewModel.onProgressTodos.suffix(DATA_SLICE_SIZE))
                                    
                                    
                                    ForEach(todos.indices, id: \.self) { index in
                                        if index < todos.count {
                                            TodoCard(todo: todos[index])
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
                                                .contextMenu {
                                                    TodoItemContextMenu(selectedTodo: todos[index], listType: .onProgress, editNavigation: $todoEditNavigation).environment(todoViewModel)
                                                }
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
                            SectionHeader(titleKey: "categories")
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(categoryViewModel.categories.indices, id: \.self) { index in
                                        CategoryCard(category: categoryViewModel.categories[index])
                                            .padding(.horizontal, (index != 0 && index != categoryViewModel.categories.count - 1) ? 4 : 0)
                                            .contextMenu {
                                                Button {
                                                    withAnimation {}
                                                } label: {
                                                    Label(String(localized: "edit"), systemImage: "pencil")
                                                }
                                                
                                                Button(role: .destructive) {
                                                    withAnimation {}
                                                } label: {
                                                    Label(String(localized: "delete"), systemImage: "trash")
                                                }
                                            }
                                    }
                                }.padding(.horizontal)
                            }
                            .padding(.vertical)
                        }
                        
                        // MARK: - Completed List
                        
                        if !todoViewModel.completedTodos.isEmpty {
                            SectionHeader(titleKey: "completed", count: todoViewModel.completedTodos.count)
                            
                            ScrollView(showsIndicators: false) {
                                ForEach(Array(todoViewModel.completedTodos).suffix(DATA_SLICE_SIZE), id: \.id) { todo in
                                    VStack {
                                        TodoCard(todo: todo, width: UIScreen.main.bounds.width - 32)
                                            .onTapGesture {
                                                withAnimation {
                                                    do {
                                                        try todoViewModel.changeTodoCompleteStatus(todo: todo)
                                                    } catch {}
                                                }
                                            }
                                            .contextMenu {
                                                TodoItemContextMenu(selectedTodo: todo, listType: .completed,editNavigation: $todoEditNavigation).environment(todoViewModel)
                                            }
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
            }.onAppear {
                Task {
                    todoViewModel.modelContext = context
                    categoryViewModel.modelContext = context
                    todoViewModel.fetchTodos()
                    categoryViewModel.fetchCategories()
                }
            }.navigationDestination(isPresented: $todoEditNavigation.isVisible){
                if let todo = todoEditNavigation.selectedTodo {
                    TodoForm(isPresentShowing: $todoEditNavigation.isVisible, todo:todo,actionType: .edit)
                        .environment(categoryViewModel)
                        .environment(todoViewModel)
                }
               
            }
            
        }
    }
}

// MARK: - Header

struct Header: View {
    // MARK: - Environment Objects
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    
    // MARK: - States
    
    @State private var progress: CGFloat = 0
    
    private var randomMotivationalMessage = MotivationalMessage.getRandomMessage()
    
    private var todoPercent: Double {
        let totalTodos = todoViewModel.onProgressTodos.count + todoViewModel.completedTodos.count
        guard totalTodos > 0 else { return 0 }
        return (Double(todoViewModel.completedTodos.count) / Double(totalTodos)) * 100
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(String(localized: "hello"))
                        .foregroundStyle(.gray)
                        .font(.regular(size: 12))
                    
                    Text(String(localized: "welcome"))
                        .foregroundStyle(.black)
                        .font(.regular(size: 14))
                }
                
                Spacer()
                
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .stroke(Color.buttonCircle, lineWidth: 1)
                            .frame(width: 36, height: 36)
                        
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                }
            }
            
            ZStack {
                Color.white
                
                HStack {
                    Text(String(localized: randomMotivationalMessage))
                        .foregroundStyle(.gray)
                        .font(.regular(size: 12))
                        .lineLimit(2)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    Circle()
                        .stroke(Color.buttonCircle, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                        .frame(width: 52, height: 52)
                        .overlay {
                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Color.black, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                                .animation(.easeInOut(duration: 1.0), value: progress)
                                .rotationEffect(.degrees(-90))
                            
                            Text(String("\(Int(todoPercent))%"))
                                .font(.regular(size: 12))
                        }
                    
                }.padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.top, 8)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = CGFloat(todoPercent / 100)
                }
            }
            .onChange(of: todoPercent) { _, newValue in
                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = CGFloat(newValue / 100)
                }
            }
        }
    }
}

// MARK: - Plus Sheet View

struct PlusSheetView: View {
    // MARK: - Environment Objects
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    @Environment(CategoryViewModel.self) private var categoryViewModel: CategoryViewModel
    
    // MARK: - States
    
    @State private var selectedTab = 0
    
    // MARK: - Bindings
    
    @Binding var isPresentShowing: Bool
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    TabButton(label: String(localized: "add_new_todo"), isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    TabButton(label: String(localized: "add_new_category"), isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                }
                .padding()
                
                Divider()
                
                TabView(selection: $selectedTab) {
                    TodoForm(isPresentShowing: $isPresentShowing,todo:todoViewModel.newTodo).tag(0)
                    
                    AddCategoryView(isPresentShowing: $isPresentShowing).tag(1)
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }.ignoresSafeArea(.all)
        }
    }
}

// MARK: - Todo Item Context Menu

struct TodoItemContextMenu: View {
    var selectedTodo: TodoItem
    var listType: TodoListType
    
    
    @Binding var editNavigation:TodoEditNavigationState
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    
    var body: some View {
        Button {
            withAnimation {
                do {
                    try todoViewModel.changeTodoCompleteStatus(todo: selectedTodo)
                } catch {}
            }
        } label: {
            Label(String(localized: selectedTodo.isDone ? "mark_as_uncompleted" : "mark_as_completed"), systemImage: "checkmark")
        }
        
        Button {
            withAnimation {
                editNavigation.selectedTodo = selectedTodo
                editNavigation.isVisible = true
            }
        } label: {
            Label(String(localized: "edit"), systemImage: "pencil")
        }
        
        Button(role: .destructive) {
            withAnimation {
                switch listType {
                case .onProgress:
                    todoViewModel.deleteTodo(from: &todoViewModel.onProgressTodos, selectedTodo)
                case .completed:
                    todoViewModel.deleteTodo(from: &todoViewModel.completedTodos, selectedTodo)
                }
            }
        } label: {
            Label(String(localized: "delete"), systemImage: "trash")
        }
    }
}

// MARK: - Section Header

struct SectionHeader: View {
    var titleKey: String.LocalizationValue
    var count: Int?
    
    var body: some View {
        HStack {
            Text(String(localized: titleKey))
                .font(.system(size: 14, weight: .regular))
            
            if count != nil {
                Circle()
                    .foregroundStyle(Color.iconButtonCircle)
                    .overlay {
                        Text("\(count!)")
                            .font(.medium(size: 12))
                    }
                    .frame(width: 18, height: 18)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text(String(localized: "view_more"))
                    .font(.system(size: 14, weight: .regular))
            }
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    let preview = Preview(TodoItem.self, Category.self)
    preview.addExamples(TodoItem.samples)
    preview.addExamples(Category.samples)
    return TodoView().modelContainer(preview.container)
}
