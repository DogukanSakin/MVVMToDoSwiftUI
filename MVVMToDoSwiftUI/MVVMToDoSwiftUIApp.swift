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
    @State private var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "hasLaunchedBefore") == false

    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                WelcomeView()
            } else {
                TodoView()
            }
        }
        .modelContainer(for: TodoItem.self)
        .modelContainer(for: Category.self)
    }
}
