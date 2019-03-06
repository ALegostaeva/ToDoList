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
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("items")
    
    init?(name: String) {
        self.name = name
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(name: name)
    }
}
