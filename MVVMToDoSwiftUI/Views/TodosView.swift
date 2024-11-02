//
//  TodosView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftUI

struct TodosView: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            Header()
        }
    }
}

// MARK: - Header

struct Header: View {
    var body: some View {
        VStack {
            HStack {
                Text("View")
                    .padding()
                Spacer()
            }
            Spacer()
        }
        
    }
}

#Preview {
    TodosView()
}
