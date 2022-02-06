//
//  StorageManager.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 06.02.2022.
//

import RealmSwift

// Объект Realm для доступа в базу данных
let realm = try! Realm() // "Точка входа" в базу данных

class StorageManager {
    
    static func saveClient(_ client: Clients) {
        
        try! realm.write {
            realm.add(client)
        }
    }
    
    static func deleteClient(_ client: Clients) {
        
        try! realm.write {
            realm.delete(client)
        }
        
    }
    
}
