//
//  Category.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Category: Identifiable {
    var id: UUID
    var name: String
    private var _containerColor: CodableColor
    private var _labelColor: CodableColor

    var containerColor: Color {
        get { _containerColor.color }
        set { _containerColor = CodableColor(color: newValue) }
    }

    var labelColor: Color {
        get { _labelColor.color }
        set { _labelColor = CodableColor(color: newValue) }
    }

    var todoItems: [TodoItem]?

    init(id: UUID, name: String, containerColor: Color, labelColor: Color = .black, todoItems: [TodoItem]? = nil) {
        self.id = id
        self.name = name
        self._containerColor = CodableColor(color: containerColor)
        self._labelColor = CodableColor(color: labelColor)
        self.todoItems = todoItems
    }
}



