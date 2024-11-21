import SwiftUI

struct OnProgressTodoCard: View {
    let todo: TodoItem
    
    // MARK: - Render
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack{
                HStack {
                    VStack(alignment:.leading){
                        
                        Text(todo.title)
                            .font(.semiBold(size: 16))
                            .lineLimit(1)
     
                        if todo.description != nil {
                            Text(todo.description!)
                                .font(.regular(size: 12))
                                .lineLimit(2)
                                .foregroundStyle(.gray)
                                .padding(.top,1)
                        }
                        
                    }
                    
                    Spacer()
                    
                }
                
                Spacer()
                
                HStack{
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        
                        Text("\(todo.date, formatter: Formatter.dateFormatter)")
                            .font(.regular(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.top,1)
                    }
                    
                    Spacer()
                }
                
            }.padding()
            
            
            VStack {
                Spacer()
                
                if let todoCategory = todo.category {
                    Rectangle()
                        .fill(todoCategory.color)
                        .frame(height: 6)
                        .frame(maxWidth: .infinity)
                }
                
               
                
            }
        }
        .frame(width: 300, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
    }
    
}

#Preview {
    ZStack{
        Color.background.edgesIgnoringSafeArea(.all)
        
        OnProgressTodoCard(todo: TodoItem(id: UUID(), title: "Test", date: .now, description: "Lorem ipsum", category: categoryWork))
    }
}
