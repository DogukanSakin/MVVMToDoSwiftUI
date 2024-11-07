import SwiftUI

struct OnProgressTodoCard: View {
    let todo: TodoItem
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(15)
            
            VStack{
                HStack {
                    VStack(alignment:.leading){
                        Text(todo.title)
                            .font(.semiBold(size: 16))
                            .lineLimit(1)
                        
                        Text("\(todo.date, formatter: dateFormatter)")
                            .font(.regular(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.top,2)
                        
                    }
                    
                    
                    Spacer()
                    
                
                }
                
                Spacer()
            }.padding()
            
            
            
        }
        .frame(width: 300, height: 200)
    }
    
    
    
    
    
}

#Preview {
    ZStack{
        Color.background.edgesIgnoringSafeArea(.all)
        
        OnProgressTodoCard(todo: TodoItem(id: UUID(), title: "Test", date: .now, description: "Lorem ipsum", category: categoryWork))
    }
}
