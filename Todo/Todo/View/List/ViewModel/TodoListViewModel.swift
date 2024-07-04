//
//  TodoListViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import RealmSwift

final class TodoListViewModel {
    
    private let repository = TodoDataRepository()
    
    private(set) var todoData: Results<TodoDTO>?
    
    init() {
        readTodoData()
    }
    
    private func readTodoData() {
        repository.readData(type: TodoDTO.self) { result in
            switch result {
            case .success(let data):
                self.todoData = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func removeTodoData(_ indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        if let todoData {
            let data = todoData[indexPath.row]
            repository.removeData(data) { result in
                completion(result)
            }
        }
    }
    
}
