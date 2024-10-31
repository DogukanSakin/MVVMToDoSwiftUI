//
//  ContentView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.themePrimary.opacity(0.8), Color.themeSecondary.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
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
                
                Text("Welcome to My App!")
                    .font(.semiBold(size: 32))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 4)
                    .padding(.top,20)
            }.padding()
        }
        
    }
}

#Preview {
    WelcomeView()
}
