//
//  AppButton.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 2.11.2024.
//

import SwiftUI

struct AppButton: View {
    var label: String = ""
    var color: Color = .button
    var labelSize: CGFloat = 16
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action, label: {
            Text(label)
                .padding()
                .font(.semiBold(size: labelSize))
                .frame(maxWidth: .infinity)
        })
        .background(color)
        .clipShape(.capsule)
        .foregroundColor(.white)
        
    }
}

#Preview {
    AppButton(label: "App Button"){}
}
