//
//  Todo.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import Foundation
import Combine


class Todo: ObservableObject {
    
    @Published var list = [TodoItem]()
    
    init() {
        loadList()
    }
    
    func saveTodo() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(list)
            try data.write(to: getFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error writing to storage: \(error.localizedDescription)")
        }
    }
    
    func loadList() {
        let path = getFilePath()
        if let data = try? Data(contentsOf: path) {
            let dec = PropertyListDecoder()
            do {
                list = try dec.decode([TodoItem].self, from: data)
            } catch {
                print("Error reading from storage: \(error.localizedDescription)")
            }
        }
    }
    
    func getItemById(id: UUID) -> TodoItem? {
        return list.first(where: {$0.id==id}) ?? nil
    }
    
    func addTodo(item: TodoItem){
        list.append(item)
        saveTodo()
    }
    
    func deleteTodo(id: UUID) {
        list.removeAll(where: {$0.id==id})
        saveTodo()
    }
    
    func editTodo(item: TodoItem) {
        if let id = list.firstIndex(where: {$0.id==item.id}) {
            list[id]=item
            saveTodo()
        }
    }
    
    func toggleTodo(id: UUID){
        if let id = list.firstIndex(where: {$0.id==id}) {
            list[id].isDone.toggle()
            saveTodo()
        }
    }
    
    
    func getFilePath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Todo.plist")
    }
    
}
