//
//  TodoListViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation

final class TodoListViewModel {
    
    private let repository = TodoDataRepository()
    
    private(set) var todoData = Binding<[TodoDTO]?>(nil)
    
    init() {
        readTodoData()
    }
    
    func readTodoData(sort: (by: String, order: ReadOrder)? = nil) {
        repository.readData(type: TodoDTO.self, sort: sort) { result in
            switch result {
            case .success(let data):
                //self.todoData.value = data
                let fixData = data.filter { $0.isFix == true }
                let nonFixData = data.filter { $0.isFix == false}
                self.todoData.value = fixData + nonFixData
            case .failure(let error):
                print(error)
            }
        }
    }
    

    func updateTodoData(_ indexPath: IndexPath) {
        removeTodoData(indexPath) { response in
            switch response {
            case true:
                self.readTodoData()
            case false:
                break
            }
        }
    }
    
    private func removeTodoData(_ indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        if let data = todoData.value?[indexPath.row] {
            repository.removeData(data) { result in
                completion(result)
            }
        }
    }
    
    private func toggleData(_ indexPath: IndexPath, item: String) -> [String: Any]? {
        var value: [String: Any]?
        
        guard let data = todoData.value else { return nil }
        
        switch item {
        case "isFix":
            if data[indexPath.row].isFix == true {
                value = ["id": data[indexPath.row].id, "isFix": false]
            } else {
                value = ["id": data[indexPath.row].id, "isFix": true]
            }
        case "isFinished":
            if data[indexPath.row].isFinished == true {
                value = ["id": data[indexPath.row].id, "isFinished": false]
            } else {
                value = ["id": data[indexPath.row].id, "isFinished": true]
            }
        default:
            break
        }
        
        return value
    }
    
    func updateToggleData(_ indexPath: IndexPath, item: String) {
        let value = toggleData(indexPath, item: item)
        
        repository.updateData(TodoDTO.self, value: value) { finish in
            switch finish {
            case true:
                self.readTodoData()
            case false:
                break
            }
        }
    }
    
  
}

enum ReadOrder {
    case asc
    case des
    
    var boolean: Bool {
        switch self {
        case .asc:
            return true
        case .des:
            return false
        }
    }
}
