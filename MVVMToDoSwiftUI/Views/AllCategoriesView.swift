//
//  AllCategoriesView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 19.12.2024.
//

import SwiftUI

struct AllCategoriesView: View {
    // MARK: - Environments
    
    @Environment(CategoryViewModel.self) private var categoryViewModel: CategoryViewModel
    
    // MARK: - States
    
    @State private var categoryFormNavigation = NavigationState<CategoryFormNavigationParams>(params: .defaultParams)
    
    // MARK: - Render
    
    var body: some View {
        if categoryViewModel.isLoading {
            ZStack {
                Color.background
                    .ignoresSafeArea(.all)
                
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
            
        } else {
            ZStack {
                Color.background
                    .ignoresSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    ForEach(categoryViewModel.categories, id: \.id) { category in
                        LazyVStack {
                            CategoryCard(category: category, width: UIScreen.main.bounds.width - 32) {
                                category in
                                categoryFormNavigation.params?.selectedCategory = category
                                categoryFormNavigation.isVisible = true
                            }
                            .environment(categoryViewModel)
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .task {
                categoryViewModel.fetchCategories()
            }
            .navigationDestination(isPresented: $categoryFormNavigation.isVisible) {
                if let category = categoryFormNavigation.params?.selectedCategory {
                    CategoryFormView(isPresentShowing: $categoryFormNavigation.isVisible, category: category, actionType: .edit)
                        .environment(categoryViewModel)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Category.self)
    preview.addExamples(Category.samples)
    
    let todoViewModel = TodoViewModel(modelContext: preview.container.mainContext)
    let categoryViewModel = CategoryViewModel(todoViewModel, modelContext: preview.container.mainContext)
    
    return AllCategoriesView()
        .environment(categoryViewModel)
        .modelContainer(preview.container)
}
