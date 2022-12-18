//
//  RowView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct RowView: View {
    
    @EnvironmentObject var todo: Todo
    @Environment(\.colorScheme) var colorScheme
    @State var isOpen = false
    @State var readToDelete = false
    @State var isAlertOpen = false
    @State var deleting = false
    @State var completedLongPress = false
    @State var viewState = CGSize.zero
    @GestureState var isLongGesture = false
    var valueToBeDeleted: CGFloat = -75
    var itemID: UUID
    var item: TodoItem? {
        return todo.getItemById(id: itemID)
    }
    
    var body: some View {
        HStack {
            Image(systemName: item?.isDone ?? false ? "circle.fill" : "circle")
                .font(.system(size: 10, weight: .black))
                .padding(.trailing,10)
                .foregroundColor(Color(item?.colorName ?? "blue"))
            Text(item?.title ?? "Sample")
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(20).background(self.readToDelete ? Color(.systemRed) : (colorScheme == .light ? Color(item?.colorName ?? "blue").opacity(0.2) : Color(.systemGray6)))
        .cornerRadius(20)
        .offset(x: self.viewState.width<0 ? self.viewState.width : 0)
        .scaleEffect((self.isLongGesture||self.viewState.width<0) ? 0.95 : (self.deleting ? 0 :1))
        .animation(.default)
        .gesture(LongPressGesture(minimumDuration: 0.5)
            .updating($isLongGesture) { current, gesture, transact in
                gesture = current
            }.onEnded{ f in
                self.isOpen = true
                Utility.hapticSuccess()
            })
        .gesture(DragGesture().onChanged{v in
            self.viewState = v.translation
            self.readToDelete = self.viewState.width<self.valueToBeDeleted
        }.onEnded{_ in
            if self.viewState.width<self.valueToBeDeleted {
                self.isAlertOpen = true
                Utility.hapticWarning()
            }
            self.viewState = .zero
            self.readToDelete = false
        })
        .gesture(LongPressGesture(minimumDuration: 0).onEnded{_ in
            self.todo.toggleTodo(id: self.itemID)
            Utility.hapticSuccess()
        })
        .alert(isPresented: self.$isAlertOpen) {
            Alert(title: Text("Delete"), message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Yes"), action: {
                self.deleting=true
                self.todo.deleteTodo(id: self.itemID)
            }),
                  secondaryButton: .cancel()
            )
        }.sheet(isPresented: self.$isOpen, onDismiss: {self.isOpen=false}) {
            EditItemView(todo: self.todo, todoItem: self.item ?? TodoItem(title: "Error"))
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(itemID: UUID()).environmentObject(Todo())
    }
}
