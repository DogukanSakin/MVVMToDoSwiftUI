//
//  AddCategoryView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct AddCategoryView: View {
    @EnvironmentObject var viewModel: CategoryViewModel
   
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
                    
                    TextField("", text: Binding(
                        get:{viewModel.newCategory.name},
                        set:{viewModel.newCategory.name = $0}
                    ))
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
                    
                    
                    ColorPicker("", selection: Binding(
                        get:{viewModel.newCategory.color},
                        set:{viewModel.newCategory.color = $0}
                    ))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                }.padding(.top)

                Text(String(localized: "preview"))
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                CategoryCard(category: viewModel.newCategory,width:UIScreen.main.bounds.width - 32)
                
                Spacer()
                
                AppButton(label: String(localized: "add_new_category"),action:{
                    do {
                        try viewModel.addCategory()
                        
                    } catch {
                        print(error)
                    }
                } ).padding(.top)
                
                
                
            }.padding()
            
            
            
        }
    }
}

#Preview {
    AddCategoryView().environmentObject(CategoryViewModel())
}


