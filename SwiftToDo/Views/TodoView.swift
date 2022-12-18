//
//  TodoView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct TodoView: View {
    
    @EnvironmentObject var todo: Todo
    
    var body: some View {
        NavigationView {
            ZStack {
                ListView().navigationTitle("Todo")
                PlusFAB()
            }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView().environmentObject(Todo())
    }
}
