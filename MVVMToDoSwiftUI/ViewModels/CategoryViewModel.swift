//
//  CategoryViewModel.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var newCategory: Category = Category(id: .init(),name: "", color: .red)
    @Published var categories: [Category] = []
    
}
