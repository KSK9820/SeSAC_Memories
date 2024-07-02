//
//  TodoDataBaseManager.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import RealmSwift

final class TodoDataBaseManager {
    
    static let shared = TodoDataBaseManager()
    
    let realm = try! Realm()

    private init() { }
    
    func saveData<T: Object>(_ data: T) {
        try! realm.write({
            realm.add(data)
        })
    }
    
    func readData<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    func removeData<T: Object>(_ data: T) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
}
