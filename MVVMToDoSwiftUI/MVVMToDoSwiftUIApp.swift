//
//  MVVMToDoSwiftUIApp.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI

@main
struct MVVMToDoSwiftUIApp: App {
    let isFirstLaunch = false

    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                WelcomeView()
            } else {
                TodoView()
            }
        }
    }
}
