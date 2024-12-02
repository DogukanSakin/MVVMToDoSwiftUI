//
//  AddCategoryView.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.11.2024.
//

import SwiftUI

struct AddCategoryView: View {
    // MARK: - Environment Objects
    
    @EnvironmentObject var viewModel: CategoryViewModel
    
    // MARK: - Bindings
    
    @Binding var isPresentShowing: Bool
    
    // MARK: - States

    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        AppInput(placeholderLocalizedValue: "category_name", text: Binding(
                            get: { viewModel.newCategory.name },
                            set: { viewModel.newCategory.name = $0 }
                        ))

                        HStack {
                            Text(String(localized: "category_color"))
                                .font(.headline)
                                .foregroundColor(.gray)

                            ColorPicker("", selection: Binding(
                                get: { viewModel.newCategory.containerColor },
                                set: { viewModel.newCategory.containerColor = $0 }
                            ))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                        }.padding(.top)

                        HStack {
                            Text(String(localized: "label_color"))
                                .font(.headline)
                                .foregroundColor(.gray)

                            ColorPicker("", selection: Binding(
                                get: { viewModel.newCategory.labelColor },
                                set: { viewModel.newCategory.labelColor = $0 }
                            ))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                        }.padding(.top)

                        Text(String(localized: "preview"))
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)

                        CategoryCard(category: viewModel.newCategory)

                        Spacer()

                        AppButton(label: String(localized: "add_new_category"), action: {
                            do {
                                try viewModel.addCategory()
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
    AddCategoryView(isPresentShowing: .constant(true)).environmentObject(CategoryViewModel())
}
