//
//  Model.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import RealmSwift


var clients = [Clients]()

// RealmSwift База данных
class Clients: Object {
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    
    convenience init(name: String, status: String) {
        self.init()
        self.name = name
        self.status = status
        
    }
}


class Workout: Object {
    @objc dynamic var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
        
    }
}

