//
//  Item.swift
//  ToDo-List
//
//  Created by Александра Легостаева on 05/03/2019.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    
    var name: String
    var date: String
    
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("items")
    
    init?(name: String, date: String) {
        self.name = name
        self.date = date
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String
        self.init(name: name, date: date)
    }
}
