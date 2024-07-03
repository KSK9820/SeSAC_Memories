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
    
    private init() { }
    
    func saveData<T: Object>(_ data: T) {
           do {
               let realm = try Realm()
               try realm.write {
                   realm.add(data)
               }
           } catch {
               print("Error saving data to Realm: \(error)")
           }
       }
       

    func readData<T: Object>(type: T.Type, completion: @escaping (Result<Results<T>, Error>) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(type)
            completion(.success(results))
            
        } catch {
            print("Error reading data from Realm: \(error)")
            completion(.failure(error))
            
        }
    }

       
       func removeData<T: Object>(_ data: T) {
           do {
               let realm = try Realm()
               try realm.write {
                   realm.delete(data)
               }
           } catch {
               print("Error removing data from Realm: \(error)")
           }
       }
    
}
