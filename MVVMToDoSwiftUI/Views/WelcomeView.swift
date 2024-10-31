//
//  ContentView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 31.10.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Hello, Custom Font!")
                .font(.semiBold(size: 24))
                        .foregroundColor(.primary)
                        .padding()
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
