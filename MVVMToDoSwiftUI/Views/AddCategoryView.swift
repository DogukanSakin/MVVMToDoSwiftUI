//
//  AddCategoryView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject var viewModel: CategoryViewModel = CategoryViewModel()
    
    var body: some View {
        ZStack{
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                VStack(alignment: .leading){
                    Text(String(localized: "category_name"))
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.bottom,8)
                    
                    TextField("", text: $viewModel.newCategory.name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                }
                
                HStack {
                    Text(String(localized: "category_color"))
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    
                    ColorPicker("", selection: $viewModel.newCategory.color)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                }.padding(.top)

                Text(String(localized: "preview"))
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                CategoryCard(category: viewModel.newCategory)
  
                
                Spacer()
                
                AppButton(label: String(localized: "add_new_category")).padding(.top)
                
                
                
            }.padding()
            
            
            
        }
    }
}

#Preview {
    AddCategoryView()
}


