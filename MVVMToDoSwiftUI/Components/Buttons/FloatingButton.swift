//
//  FloatingButton.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 7.11.2024.
//

import SwiftUI

struct FloatingButton: View {
    // MARK: - Props

    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.appButton)
                    .frame(width: 56, height: 56)

                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
        }
        .padding(.bottom, 32)
        .padding(.trailing, 16)
    }
}

#Preview {
    FloatingButton()
}
