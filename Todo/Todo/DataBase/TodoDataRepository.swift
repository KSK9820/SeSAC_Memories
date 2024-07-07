//
//  TodoDataBaseManager.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import RealmSwift

final class TodoDataRepository {
    
    func saveData<T: Object>(_ data: T, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
//            print(realm.configuration.fileURL)
            completion(true)
        } catch {
            print("Error saving data to Realm: \(error)")
            completion(false)
        }
    }
    
    
    func readData<T: Object>(type: T.Type, sort: (by: String, order: ReadOrder)? = nil, completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            let realm = try Realm()
            if let sort {
                let results = Array(realm.objects(type).sorted(byKeyPath: sort.by, ascending: sort.order.boolean))
                completion(.success(results))
            } else {
                let results = Array(realm.objects(type))
                completion(.success(results))
            }
        } catch {
            print("Error reading data from Realm: \(error)")
            completion(.failure(error))
            
        }
    }
    
    
    func removeData<T: Object>(_ data: T, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(data)
            }
            completion(true)
        } catch {
            print("Error removing data from Realm: \(error)")
            completion(false)
        }
    }
    
    func updateData<T: Object>(_ data: T.Type, value: Any, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(T.self, value: value, update: .modified)
                completion(true)
            }
        } catch {
            print("Error updating data from Realm: \(error)")
            completion(false)
        }
    }
    
}
