//
//  CategoryCard.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct CategoryCard: View {
    let category:Category
    
    var body: some View {
        ZStack{
            Color.white
            
            HStack{
                Circle()
                    .fill(category.color)
                    .frame(width: 14, height: 14)
                
                Text(category.name)
                    .font(.semiBold(size: 16))
                    .lineLimit(1)
            }.padding(.horizontal)
            
        }
        .frame(width: 160, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(category.color, lineWidth: 1)
        )
    }
}

#Preview {
    ZStack{
        Color.background.edgesIgnoringSafeArea(.all)
        CategoryCard(category: .init(id: UUID(), name: "CategoryCategoryCategoryCategory", color: .yellow,todoItems: []))
    }
}
