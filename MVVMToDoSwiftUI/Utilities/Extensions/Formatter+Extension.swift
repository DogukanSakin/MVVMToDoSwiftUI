//
//  Formatter+Extension.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 9.11.2024.
//

import Foundation

extension Formatter {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
