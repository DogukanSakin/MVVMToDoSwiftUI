//
//  SectionHeader.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 19.12.2024.
//

import SwiftUI

// MARK: - Navigation Params

enum ViewAllNavigationParams: Hashable {
    case category
    case todo(TodoListType)
}

struct SectionHeader: View {
    // MARK: - Props
    
    var titleKey: String.LocalizationValue
    var count: Int?
    var viewAllType: ViewAllNavigationParams = .category
    
    // MARK: - Bindings
    
    @Binding var navigation: NavigationState<ViewAllNavigationParams>
    
    // MARK: - Render
     
    var body: some View {
        HStack {
            Text(String(localized: titleKey))
                .font(.system(size: 14, weight: .regular))
             
            if count != nil {
                Circle()
                    .foregroundStyle(Color.circleColor)
                    .overlay {
                        Text("\(count!)")
                            .font(.medium(size: 12))
                    }
                    .frame(width: 18, height: 18)
            }
             
            Spacer()
             
            Button(action: {
                navigation.isVisible = true
                navigation.params = viewAllType
            }) {
                Text(String(localized: "view_more"))
                    .font(.system(size: 14, weight: .regular))
            }
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    SectionHeader(titleKey: "lorem", navigation: .constant(.init()))
}
