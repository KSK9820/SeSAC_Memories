//
//  AddNewToDoViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import Foundation

final class AddNewToDoViewModel {
    
    private(set) var todoData = TodoDTO(title: "")
    
    func validateInput() -> Bool {
        if todoData.title.isEmpty { return false }
        
        saveTodoData()
        
        return true
    }
    
    func saveTitle(_ title: String?) {
        todoData.title = title ?? ""
    }
    
    
    private func saveTodoData() {
        TodoDataBaseManager.shared.saveData(todoData)
    }
    
}

enum TodoStatus {
    case today
    case schedule
    case all
    case flag
    case complete
}


