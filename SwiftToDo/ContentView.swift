//
//  ContentView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI
import CoreData


struct ToDoView: View {

    @State var todos = [
            TodoItem(title: "Study"),
            TodoItem(title: "Finish App"),
            TodoItem(title: "Do Yoga"),
            TodoItem(title: "Meditate"),
            TodoItem(title: "Workout"),
        ]
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(todos) { item in
                        HStack {
                            Image(systemName: item.isDone ? "checkmark.circle" : "circle")
                            Text(item.title)
                            Spacer()
                        }
                        .background(Color(.systemBackground))
                        .onTapGesture {
                            if let matchingIndex = self.todos.firstIndex(where: { $0.id == item.id }) {
                                self.todos[matchingIndex].isDone.toggle()
                            }
                        }
                    }
                    .onDelete(perform: deleteListItem)
                    .onMove(perform: moveListItem)
                }
                .navigationBarItems(trailing: EditButton())
                .navigationBarTitle("Checklist")
            }
        }
        
        func deleteListItem(whichElement: IndexSet) {
            todos.remove(atOffsets: whichElement)
        }
        
        func moveListItem(whichElement: IndexSet, destination: Int) {
            todos.move(fromOffsets: whichElement, toOffset: destination)
        }
    
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
