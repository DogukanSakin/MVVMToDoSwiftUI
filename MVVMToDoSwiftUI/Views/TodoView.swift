//
//  TodosView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodosViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            ZStack{
                Header()
            }.padding()
            
            VStack{
                Spacer()
                
                HStack {
                    Spacer()
                    
                    FloatingButton()
                }
            }
            
            
        }
    }
}

// MARK: - Header

struct Header: View {
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading){
                    Text(String(localized: "hello")).foregroundStyle(.gray).font(.system(size: 12, weight: .regular))
                    Text(String(format: NSLocalizedString("tasks_waiting", comment: ""), 0)).font(.system(size: 14, weight: .regular))
                }
                
                Spacer()
                
                Button(action: {}){
                    ZStack{
                        Circle()
                            .stroke(Color.buttonCircle, lineWidth: 1)
                            .frame(width: 36,height: 36)
                        
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        
    }
}

#Preview {
    TodoView()
}
