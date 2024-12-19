//
//  BaseHeader.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 19.12.2024.
//

import SwiftUI

struct BaseHeader: View {
    // MARK: - Environment Objects
    
    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel
    
    // MARK: - States
    
    @State private var progress: CGFloat = 0
    
    // MARK: - Props
    
    private var randomMotivationalMessage = MotivationalMessage.getRandomMessage()
    
    private var todoPercent: Double {
        let totalTodos = todoViewModel.onProgressTodos.count + todoViewModel.completedTodos.count
        guard totalTodos > 0 else { return 0 }
        return (Double(todoViewModel.completedTodos.count) / Double(totalTodos)) * 100
    }
    
    // MARK: - Render
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(String(localized: "hello"))
                        .foregroundStyle(.gray)
                        .font(.regular(size: 12))
                    
                    Text(String(localized: "welcome"))
                        .font(.regular(size: 14))
                }
                
                Spacer()
            }
            
            ZStack {
                Color.cardColor
                    .ignoresSafeArea(.all)
                
                HStack {
                    Text(String(localized: randomMotivationalMessage))
                        .foregroundStyle(.gray)
                        .font(.regular(size: 12))
                        .lineLimit(2)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    Circle()
                        .stroke(Color.circleColor, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                        .frame(width: 52, height: 52)
                        .overlay {
                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Color.button, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                                .animation(.easeInOut(duration: 1.0), value: progress)
                                .rotationEffect(.degrees(-90))
                            
                            Text(String("\(Int(todoPercent))%"))
                                .font(.regular(size: 12))
                        }
                    
                }.padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.top, 8)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = CGFloat(todoPercent / 100)
                }
            }
            .onChange(of: todoPercent) { _, newValue in
                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = CGFloat(newValue / 100)
                }
            }
        }
    }
}

#Preview {
    BaseHeader().environment(TodoViewModel())
}
