//
//  CategorySamples.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 12.12.2024.
//

import Foundation

extension Category {
    static var samples: [Category] {
        [
            .init(id: UUID(), name: "Category 1", containerColor: .red),
            .init(id: UUID(), name: "Category 2", containerColor: .green),
            .init(id: UUID(), name: "Category 3", containerColor: .blue),
            .init(id: UUID(), name: "Category 4", containerColor: .cyan),
        ]
    }
}
