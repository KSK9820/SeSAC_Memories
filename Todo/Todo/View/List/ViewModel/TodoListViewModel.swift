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
    
    private func readTodoData() {
        repository.readData(type: TodoDTO.self) { result in
            switch result {
            case .success(let data):
                self.todoData.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateTodoData(_ indexPath: IndexPath) {
        removeTodoData(indexPath) { response in
            switch response {
            case true:
                self.reloadTodoData()
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
        
    private func reloadTodoData() {
        repository.readData(type: TodoDTO.self, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.todoData.value = data
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
