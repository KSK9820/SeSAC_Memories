//
//  TodoDataBaseManager.swift
//  Todo
//
//  Created by 김수경 on 7/3/24.
//

import Foundation
import RealmSwift

final class TodoDataRepository {
    
//    static let shared = TodoDataRepository()
    
//    private init() { }
    
    func saveData<T: Object>(_ data: T, completion: @escaping (Bool) -> Void) {
           do {
               let realm = try Realm()
               try realm.write {
                   realm.add(data)
               }
               completion(true)
           } catch {
               print("Error saving data to Realm: \(error)")
               completion(false)
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
    
}
