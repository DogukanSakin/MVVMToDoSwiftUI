//
//  PreviewContainer.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 12.12.2024.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer

    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let scheme = Schema(models)
        do {
            container = try ModelContainer(for: scheme, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    func addExamples(_ examples: [any PersistentModel]) {
        print(examples)
        Task { @MainActor in
            for example in examples {
                container.mainContext.insert(example)
            }
        }
    }
}
