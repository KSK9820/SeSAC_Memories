//
//  AddNewToDoViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import Foundation

final class AddNewToDoViewModel {
    
    private let repository = TodoDataRepository()
    
    private(set) var todoData = TodoDTO(title: "")
    
    
    // MARK: - Method
    
    func validateInput(_ completion: @escaping ((Bool) -> Void)) {
        if todoData.title.isEmpty {
            completion(false)
            return
        }
        
        saveTodoData { result in
            completion(result)
        }
    }
    
    func saveTitle(_ title: String?) {
        todoData.title = title ?? ""
    }
    
    func saveContent(_ content: String?) {
        todoData.content = content
    }
    
    
    private func saveTodoData(_ completion: @escaping ((Bool) -> Void)) {
        repository.saveData(todoData) { result in
            completion(result)
        }
    }
    
}

enum TodoStatus {
    case today
    case schedule
    case all
    case flag
    case complete
}


