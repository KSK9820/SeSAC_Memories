//
//  TodoListViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation

final class TodoListViewModel {
    
    private let fileManager = ImageFileManager()
    private let repository = TodoDataRepository()
    
    private(set) var todoData = Binding<[TodoDTO]?>(nil)
    private(set) var filteredTodoData = Binding<[TodoDTO]?>(nil)
    
    var classifyType: ClassifyTodo
    
    init(_ classifyType: ClassifyTodo) {
        self.classifyType = classifyType
        readTodoData()
    }
    
    func readTodoData(sort: (by: String, order: ReadOrder)? = nil, search: String? = nil) {
        var predicate: NSPredicate?
        if let search {
            predicate = createPredicate(for: search)
        }
        repository.readData(type: TodoDTO.self, sort: sort, predicator: predicate) { result in
            switch result {
            case .success(let data):
                let fixData = data.filter { $0.isFix == true }
                let nonFixData = data.filter { $0.isFix == false}
                let data = fixData + nonFixData
                
                switch self.classifyType {
                case .today:
                    self.todoData.value = data.filter { $0.dueDate == Date() }
                case .schedule:
                    self.todoData.value = data.filter { $0.dueDate ?? Date() > Date() }
                case .all:
                    self.todoData.value = data
                case .flag:
                    self.todoData.value = fixData
                case .complete:
                    self.todoData.value = data.filter { $0.isFinished }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createPredicate(for searchText: String) -> NSPredicate {
        let predicate = NSPredicate(format: "title CONTAINS[c] %@ OR content CONTAINS[c] %@", searchText, searchText)
        return predicate
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
            if let imageName = data.imageName {
                fileManager.removeImageFromDocument(filename: imageName)
            }
            
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
