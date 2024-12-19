import SwiftUI

struct TodoCard: View {
    // MARK: - Props

    let todo: TodoItem
    var width: CGFloat = 300
    var listType: TodoListType = .completed
    var onTapEdit: (TodoItem) -> Void = { _ in }

    // MARK: - Environments

    @Environment(TodoViewModel.self) private var todoViewModel: TodoViewModel

    // MARK: - Render

    var body: some View {
        ZStack {
            Color.cardColor

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(todo.title)
                            .font(.semiBold(size: 16))
                            .lineLimit(1)

                        if todo.comment != nil {
                            Text(todo.comment!)
                                .font(.regular(size: 12))
                                .lineLimit(2)
                                .foregroundStyle(.gray)
                                .padding(.top, 1)
                        }
                    }

                    Spacer()
                }

                Spacer()

                HStack {
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))

                        Text("\(todo.date, formatter: Formatter.dateFormatter)")
                            .font(.regular(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.top, 1)
                    }

                    Spacer()

                    if todo.category != nil {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(todo.category!.containerColor.opacity(0.1))
                            .frame(width: 60, height: 20)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(todo.category!.containerColor, lineWidth: 1)
                                .overlay(
                                    Text(todo.category!.name)
                                        .font(.medium(size: 10))
                                        .foregroundStyle(todo.category!.containerColor)
                                ))
                    }
                }

            }.padding()

            VStack {
                Spacer()
            }
        }
        .frame(width: width, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .contextMenu {
            Button {
                withAnimation {
                    do {
                        try todoViewModel.changeTodoCompleteStatus(todo: todo)
                    } catch {}
                }
            } label: {
                Label(String(localized: todo.isDone ? "mark_as_uncompleted" : "mark_as_completed"), systemImage: "checkmark")
            }

            Button {
                onTapEdit(todo)
            } label: {
                Label(String(localized: "edit"), systemImage: "pencil")
            }

            Button(role: .destructive) {
                withAnimation {
                    do {
                        try todoViewModel.deleteTodo(todo)

                        switch listType {
                        case .onProgress:
                            guard let removeIndex = todoViewModel.onProgressTodos.firstIndex(where: { $0.id == todo.id }) else { return }
                            todoViewModel.onProgressTodos.remove(at: removeIndex)

                        case .completed:
                            guard let removeIndex = todoViewModel.completedTodos.firstIndex(where: { $0.id == todo.id }) else { return }
                            todoViewModel.completedTodos.remove(at: removeIndex)
                        }
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

        TodoCard(todo: TodoItem(id: UUID(), title: "Test", date: .now, comment: "Lorem ipsum", category: Category(id: UUID(), name: "Work", containerColor: .red, todoItems: [])), onTapEdit: { _ in })
            .environment(TodoViewModel())
    }
}
