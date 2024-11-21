//
//  MVVMToDoSwiftUIApp.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI

@main
struct MVVMToDoSwiftUIApp: App {
    @StateObject private var todoViewModel = TodoViewModel()
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    let isFirstLaunch = false
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                WelcomeView()
            }else{
                TodoView().environmentObject(todoViewModel).environmentObject(categoryViewModel)
            }
          
        }
    }
}
