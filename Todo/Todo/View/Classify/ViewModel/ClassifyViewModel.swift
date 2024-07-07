//
//  ClassifyViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/8/24.
//

import UIKit

final class ClassifyViewModel {
    
    private let repository = TodoDataRepository()
    
    private(set) var todoData = Binding<[TodoDTO]?>(nil)
    
    var todoCount: [Int]?
    
    init() {
        readTodoData()
    }
    
    
    func readTodoData() {
        repository.readData(type: TodoDTO.self) { result in
            switch result {
            case .success(let data):
                self.todoData.value = data
                self.todoCount = self.getTodoCount()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getTodoCount() -> [Int] {
        guard let data = todoData.value else { return [0,0,0,0,0] }
        
        var count = Array(repeating: 0, count: 5)
        
        count[0] = data.filter { $0.dueDate == Date() }.count
        count[1] = data.filter { $0.dueDate ?? Date() > Date() }.count
        count[2] = data.count
        count[3] = data.filter { $0.isFix }.count
        count[4] = data.filter { $0.isFinished }.count
        
        return count
    }
}
