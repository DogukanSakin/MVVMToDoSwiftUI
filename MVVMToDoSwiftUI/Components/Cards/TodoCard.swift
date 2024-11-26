import SwiftUI

struct TodoCard: View {
    let todo: TodoItem
    var width: CGFloat = 300
    
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
                    
                    if todo.category != nil {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(todo.category!.containerColor.opacity(0.1))
                            .frame(width:60,height: 20)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(todo.category!.containerColor,lineWidth: 1)
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
        
    }
    
}

#Preview {
    ZStack{
        Color.background.edgesIgnoringSafeArea(.all)
        
        TodoCard(todo: TodoItem(id: UUID(), title: "Test", date: .now, description: "Lorem ipsum", category: categoryWork))
    }
}
