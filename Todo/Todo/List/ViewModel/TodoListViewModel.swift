//
//  TodoListViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import RealmSwift

final class TodoListViewModel {
    
    private(set) var todoData: Results<TodoDTO>?
    
    init() {
        self.todoData = TodoDataBaseManager.shared.readData(type: TodoDTO.self)
    }
    
    
    
    
}
