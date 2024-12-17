//
//  Settings.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 17.12.2024.
//

import Foundation
import SwiftData

@Model
final class LaunchSettings {
    @Attribute(.unique) var id: String 
    var isFirstLaunch: Bool
    
    init(id: String = UUID().uuidString, isFirstLaunch: Bool = true) {
        self.id = id
        self.isFirstLaunch = isFirstLaunch
    }
}
