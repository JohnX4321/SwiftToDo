//
//  ListView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var todo: Todo
    
    var body: some View {
        List {
            ForEach(self.todo.list.sorted(by: {$0.colorName<$1.colorName})) { i in
                RowView(itemID: i.id)
            }.onDelete{ indexSet in
                self.todo.list.remove(atOffsets: indexSet)
                self.todo.saveTodo()
            }.animation(.default).onAppear() {
                UITableView.appearance().separatorColor = .clear
            }
                
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
