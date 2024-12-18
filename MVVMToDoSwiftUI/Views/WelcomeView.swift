//
//  WelcomeView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI
import SwiftData

struct WelcomeView: View {
    // MARK: - States
    
    @State private var navigateToTodos = false
   

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.welcomePagePrimaryColor, Color.welcomePageSecondaryColor]), startPoint: .top, endPoint: .bottom)
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
                        .frame(width: 325, height: 325)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text(String(localized: "welcome"))
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 4)
                        .padding(.top, 20)
                    
                    AppButton(label: String(localized: "start")) {
                        UserDefaults.standard.set(true, forKey: Constants.appLaunchKey)
                        navigateToTodos = true
                    }
                    .padding()
                    .navigationDestination(isPresented: $navigateToTodos) {
                        TodoView().navigationBarBackButtonHidden(true)
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
