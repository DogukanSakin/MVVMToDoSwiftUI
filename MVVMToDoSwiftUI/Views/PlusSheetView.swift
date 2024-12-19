//
//  PlusSheetView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 19.12.2024.
//

import SwiftUI

struct PlusSheetView: View {
    // MARK: - Environment Objects
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    @Environment(CategoryViewModel.self) private var categoryViewModel: CategoryViewModel
    
    // MARK: - States
    
    @State private var selectedTab = 0
    
    // MARK: - Bindings
    
    @Binding var isPresentShowing: Bool
    
    // MARK: - Render
    
    var body: some View {
        ZStack {
            Color.background
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
                    TodoFormView(isPresentShowing: $isPresentShowing, todo: todoViewModel.newTodo).tag(0)
                    
                    CategoryFormView(isPresentShowing: $isPresentShowing, category: categoryViewModel.newCategory).tag(1)
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }.ignoresSafeArea(.all)
        }
    }
}

#Preview {
    PlusSheetView(isPresentShowing: .constant(true)).environment(TodoViewModel()).environment(CategoryViewModel())
}
