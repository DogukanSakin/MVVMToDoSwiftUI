//
//  TabButton.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct NoOpacityButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(1.0)
    }
}

struct TabButton: View {
    var label: String = ""
    var isSelected: Bool
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action, label: {
            Text(label)
                .font(.regular(size: 14))
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.button : Color.clear)
                .cornerRadius(8)
        })
        .buttonStyle(NoOpacityButtonStyle())
    }
}

#Preview {
    TabButton(label:"Tab Label",isSelected: true)
}
