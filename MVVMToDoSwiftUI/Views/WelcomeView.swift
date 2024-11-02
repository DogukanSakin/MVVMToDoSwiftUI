//
//  ContentView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI

import SwiftUI

struct WelcomeView: View {
    @State private var navigateToTodos = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.themePrimary.opacity(0.5), Color.themeSecondary.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .position(x: 100, y: 100)
                
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 300, height: 300)
                    .position(x: 300, y: 300)
                
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 150, height: 150)
                    .position(x: 250, y: 100)
                
                VStack {
                    Image("WelcomeImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("Welcome to Today!")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 4)
                        .padding(.top, 20)
                    
                    AppButton(label: "Let's Start") {
                        navigateToTodos = true
                    }
                    .padding()
                    .navigationDestination(isPresented: $navigateToTodos) {
                        TodosView().navigationBarBackButtonHidden(true)
                    }
                    
                    
                    
                }
                .padding()
                
            }
        }
    }
}

#Preview {
    WelcomeView()
}


