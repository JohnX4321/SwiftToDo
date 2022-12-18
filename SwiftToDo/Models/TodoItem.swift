//
//  TodoItem.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import Foundation


struct TodoItem: Identifiable, Codable {
    let id = UUID()
    var title: String = ""
    var isDone: Bool = false
    var colorName: String = "green"
}
