//
//  MVVMToDoSwiftUIApp.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftData
import SwiftUI

@main
struct MVVMToDoSwiftUIApp: App {
    @State private var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: Constants.appLaunchKey) == false
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isFirstLaunch {
                    WelcomeView()
                } else {
                    TodoView(context: container.mainContext)
                }
            }
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: TodoItem.self, Category.self)
        } catch {
            fatalError("Failed to create ModelContainer")
        }
    }
}
