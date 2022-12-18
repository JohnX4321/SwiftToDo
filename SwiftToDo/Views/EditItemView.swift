//
//  EditItemView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct EditItemView: View {
    
    var todo: Todo
    @State var todoItem: TodoItem
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Text("Edit").font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    self.todo.editTodo(item: self.todoItem)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Apply").fontWeight(.medium)
                }).disabled(todoItem.title.count==0)
            }.padding([.top,.horizontal])
            TextField("Edit Todo",text: self.$todoItem.title)
                .font(.system(size: 20)).padding(20)
                .background(Color(.systemGray4))
                .cornerRadius(20).padding(.bottom)
            ColorPickerView(choosenColor: self.$todoItem.colorName)
            Spacer()
            HStack {
                Spacer()
                Text("Swipe down to cancel")
                    .foregroundColor(.secondary).padding(.top)
                Spacer()
            }
        }).padding(25)
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(todo: Todo(), todoItem: TodoItem())
    }
}
