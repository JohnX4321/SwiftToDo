//
//  PlusFAB.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct PlusFAB: View {
    
    @EnvironmentObject var todo: Todo
    @State var isOpen = false
    @GestureState var isLongGesture = false
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Circle().foregroundColor(.mint).opacity(0.1)
                        .frame(width: 100, height: 100)
                    Circle().foregroundColor(.mint).opacity(0.2)
                        .frame(width: 70, height: 70)
                    Circle().foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Image(systemName: "plus.circle.fill").font(.system(size: 40))
                        .foregroundColor(.teal)
                }.scaleEffect(self.isLongGesture ? 0.8 : 1)
                    .animation(.spring())
            }
        }.padding(.bottom,20)
            .padding(.trailing,20)
            .gesture(
                LongPressGesture(minimumDuration: 0.5).updating($isLongGesture) { current, gesture, transaction in
                    gesture = current
                }.onEnded{_ in
                    self.isOpen=true
                    Utility.hapticSuccess()
                }
            )
            .gesture(LongPressGesture(minimumDuration: 0).onEnded{_ in
                self.isOpen = true
                Utility.hapticSuccess()
            })
            .sheet(isPresented: self.$isOpen) {
                NewItemView(todo: self.todo)
            }
    }
}

struct PlusFAB_Previews: PreviewProvider {
    static var previews: some View {
        PlusFAB().environmentObject(Todo())
    }
}
