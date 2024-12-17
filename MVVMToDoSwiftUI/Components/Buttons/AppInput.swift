//
//  AppInput.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 26.11.2024.
//

import SwiftUI

struct AppInput: View {
    // MARK: - Props

    var placeholderLocalizedValue: String.LocalizationValue = ""
    var isTextArea: Bool = false

    // MARK: - Bindings

    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(String(localized: placeholderLocalizedValue))
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            if isTextArea {
                TextEditor(text: $text)
                    .frame(height: 140)
                    .padding(8)
                    .background(Color.cardColor)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.cardColor))
                    .scrollContentBackground(.hidden)
            } else {
                TextField("", text: $text)
                    .frame(height: 52)
                    .padding(.horizontal, 12)
                    .background(Color.cardColor)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.cardColor))
            }
        }
    }
}

#Preview {
    AppInput(isTextArea: true, text: .constant("Test"))
}
