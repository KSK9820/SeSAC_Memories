//
//  CalendarViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/9/24.
//

import Foundation

final class CalendarViewModel {
    
    private let repository = TodoDataRepository()
    
    private(set) var todoData = Binding<[TodoDTO]?>(nil)
    
    init() {
        readTodoData(Date())
    }
    
    func readTodoData(_ date: Date) {
        let predicate = makePredicator(date)
        repository.readData(type: TodoDTO.self, predicator: predicate) { result in
            switch result {
            case .success(let data):
                self.todoData.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func makePredicator(_ start: Date) -> NSPredicate {
        let startOfDay = Calendar.current.startOfDay(for: start)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = NSPredicate(format: "dueDate >= %@ AND dueDate < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        return predicate
    }
    
}
