//
//  AddCategoryView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

// MARK: - Category Form Action Type

enum CategoryFormActionType{
    case edit
    case add
}

struct CategoryFormView: View {
    // MARK: - Environment Objects
    
    @Environment(CategoryViewModel.self) private var viewModel: CategoryViewModel
    
    // MARK: - Bindings
    
    @Binding var isPresentShowing: Bool
    
    // MARK: - Props
    
    var category:Category
    var actionType: CategoryFormActionType = .add
    
    // MARK: - States

    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        AppInput(placeholderLocalizedValue: "category_name", text: Binding(
                            get: { category.name },
                            set: { category.name = $0 }
                        ))

                        HStack {
                            Text(String(localized: "category_color"))
                                .font(.headline)
                                .foregroundColor(.gray)

                            ColorPicker("", selection: Binding(
                                get: { category.containerColor },
                                set: { category.containerColor = $0 }
                            ))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                        }.padding(.top)

                        HStack {
                            Text(String(localized: "label_color"))
                                .font(.headline)
                                .foregroundColor(.gray)

                            ColorPicker("", selection: Binding(
                                get: { category.labelColor },
                                set: { category.labelColor = $0 }
                            ))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                        }.padding(.top)

                        Text(String(localized: "preview"))
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)

                        CategoryCard(category: category)

                        Spacer()

                        AppButton(label: String(localized: actionType == .add ? "add_new_category" : "save"), action: {
                            do {
                                try actionType == .add ? viewModel.addCategory() : viewModel.updateCategory(category)
                                isPresentShowing = false
                            } catch let error as CategoryFormValidationError {
                                alertMessage = error.errorDescription
                                isShowAlert = true
                            } catch {}
                        }).padding(.top)
                            .alert(alertMessage, isPresented: $isShowAlert) {
                                Button("OK", role: .cancel) {}
                            }
                    }
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    CategoryFormView(isPresentShowing: .constant(true),category:CategoryViewModel().newCategory).environment(CategoryViewModel())
}
