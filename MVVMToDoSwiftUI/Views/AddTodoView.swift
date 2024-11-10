//
//  AddTodoView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct AddTodoView: View {
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea(.all)
            
            Text("Add Todo")
        }
    }
}

#Preview {
    AddTodoView()
}
