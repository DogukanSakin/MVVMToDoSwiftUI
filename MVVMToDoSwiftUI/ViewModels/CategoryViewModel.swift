//
//  CategoryViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import Foundation
import SwiftUI

private enum ValidationError:Error{
    case empty
    case alreadyAdded
    
    var errorDescription:String {
        switch self {
        case .empty: String(localized: "empty_category_name")
        case .alreadyAdded: String(localized: "already_added_category")
        }
    }
}

class CategoryViewModel: ObservableObject {
    @Published var newCategory: Category = .init(id: UUID(), name: "", color: .red)
    @Published var categories: [Category] = [
        .init(id: UUID(), name: "Work", color: .red),
        .init(id: UUID(), name: "Home", color: .blue),
        .init(id: UUID(), name: "Personal", color: .green)
    ]
    
    func addCategory() throws {
        print("adding...")
        guard !newCategory.name.isEmpty else { throw ValidationError.empty }
        guard !categories.contains(where: {$0.name == newCategory.name && $0.color == newCategory.color}) else { throw ValidationError.alreadyAdded }
        self.categories.append(self.newCategory)
        print("added...")
        
        
    }
    
}
