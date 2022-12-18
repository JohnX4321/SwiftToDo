//
//  NewItemView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct NewItemView: View {
    
    var todo: Todo
    @State var newItemTitle = ""
    @State var newItemColor = "orange"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Text("New todo").font(.largeTitle).fontWeight(.bold)
                Spacer()
                Button(action: {
                    let newItem = TodoItem(title: self.newItemTitle,colorName: self.newItemColor)
                    self.todo.addTodo(item: newItem)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Apply").fontWeight(.medium)
                }).disabled(newItemTitle.count==0)
            }.padding([.top,.horizontal])
            TextField("New Todo", text: $newItemTitle)
                .font(.system(size: 20)).padding(20).background(Color(.systemGray4))
                .cornerRadius(20).padding(.bottom)
            ColorPickerView(choosenColor: self.$newItemColor)
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

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(todo: Todo())
    }
}
