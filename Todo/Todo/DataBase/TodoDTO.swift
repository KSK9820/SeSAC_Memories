//
//  TodoDTO.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import RealmSwift

final class TodoDTO: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var content: String?
    @Persisted var dueDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    @Persisted var Image: Data?
    
  
    convenience init(title: String, content: String? = nil, dueDate: Date? = nil, tag: String? = nil, priority: Int? = nil, image: Data? = nil) {
        self.init()
        
        self.title = title
        self.content = content
        self.dueDate = dueDate
        self.tag = tag
        self.priority = priority
        self.Image = image
    }
}
