//
//  CategoryCard.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct CategoryCard: View {
    // MARK: - Props

    let category: Category
    var width: CGFloat = 160
    var onTapEdit: (Category) -> Void = { _ in }

    // MARK: - Environments

    @Environment(CategoryViewModel.self) private var categoryViewModel: CategoryViewModel

    // MARK: - Render

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [category.containerColor.opacity(0.4), category.containerColor.opacity(0.6), category.containerColor.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 12)
                    .frame(width: 80, height: 80)
                    .position(x: 10, y: 10)

                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 12)
                    .frame(width: 80, height: 80)
                    .position(x: 90, y: 90)

                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 12)
                    .frame(width: 80, height: 80)
                    .position(x: 10, y: width)
            }.blur(radius: 2)

            VStack {
                Spacer()

                Text(category.name)
                    .font(.semiBold(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(category.labelColor)

                Spacer()

                if let categoryTasks = category.todoItems {
                    HStack(alignment: .bottom) {
                        Spacer()

                        Text(String(format: NSLocalizedString("category_tasks", comment: ""), categoryTasks.count))
                            .font(.medium(size: 12))
                            .foregroundStyle(category.labelColor)
                    }
                }
            }.padding()
        }
        .frame(width: width, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .contextMenu {
            Button {
                onTapEdit(category)
            } label: {
                Label(String(localized: "edit"), systemImage: "pencil")
            }

            Button(role: .destructive) {
                withAnimation {
                    do {
                        try categoryViewModel.deleteCategory(category)
                        guard let removeIndex = categoryViewModel.categories.firstIndex(where: { $0.id == category.id }) else { return }
                        categoryViewModel.categories.remove(at: removeIndex)
                    } catch {}
                }
            } label: {
                Label(String(localized: "delete"), systemImage: "trash")
            }
        }
    }
}

#Preview {
    ZStack {
        Color.background.edgesIgnoringSafeArea(.all)
        CategoryCard(category: .init(id: UUID(), name: "CategoryCategoryCategoryCategory", containerColor: .yellow, todoItems: []), onTapEdit: { _ in })
            .environment(CategoryViewModel())
    }
}
