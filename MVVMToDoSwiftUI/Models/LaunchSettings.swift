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
    var isFirstLaunch: Bool

    init(isFirstLaunch: Bool = true) {
        self.isFirstLaunch = isFirstLaunch
    }
}
