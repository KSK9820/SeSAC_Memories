//
//  AddNewToDoViewModel.swift
//  Todo
//
//  Created by 김수경 on 7/2/24.
//

import Foundation

final class AddNewToDoViewModel {
    
    private let repository = TodoDataRepository()
    private let fileManager = ImageFileManager()
    
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
    
    func saveDueDate(_ date: Date?) {
        todoData.dueDate = date
    }
    
    func saveTag(_ tag: String?) {
        todoData.tag = tag
    }
    
    func savePriority(_ priority: Int) {
        todoData.priority = priority
    }
    
    func saveImage(_ image: Data) {
        fileManager.saveImageToDocument(data: image, filename: "\(todoData.id)")
        todoData.imageName = "\(todoData.id).jpg"
    }
    
    private func saveTodoData(_ completion: @escaping ((Bool) -> Void)) {
        repository.saveData(todoData) { result in
            completion(result)
        }
    }
    
}




