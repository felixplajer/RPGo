//
//  Item.swift
//  RPGo
//
//  Created by Felix Plajer on 12/10/17.
//  Copyright © 2017 Felix Plajer. All rights reserved.
//

import UIKit
import os.log

class Item: NSObject, NSCoding {
    
    convenience init(image: String, type: ItemType, value: Int) {
        self.init(image: UIImage(named: image)!, type: type, value: value, equipped: false)
    }
    
    init(image: UIImage, type: ItemType, value: Int, equipped: Bool) {
        self.image = image
        self.type = type
        self.value = value
        self.equipped = equipped
    }

    var image: UIImage
    var type: ItemType
    var value: Int
    var equipped: Bool
    
    enum ItemType: String, Codable {
        case Attack
        case Defense
        case Health
    }
    
    struct ItemKey {
        static let image = "image"
        static let type = "type"
        static let value = "value"
        static let equipped = "equipped"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: ItemKey.image)
        try? (aCoder as! NSKeyedArchiver).encodeEncodable(type, forKey: ItemKey.type)
        aCoder.encode(value, forKey: ItemKey.value)
        aCoder.encode(equipped, forKey: ItemKey.equipped)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let image = aDecoder.decodeObject(forKey: ItemKey.image) as! UIImage
        let type = (aDecoder as! NSKeyedUnarchiver).decodeDecodable(ItemType.self, forKey: ItemKey.type)!
        let value = aDecoder.decodeInteger(forKey: ItemKey.value)
        let equipped = aDecoder.decodeBool(forKey: ItemKey.equipped)
        
        self.init(image: image, type: type, value: value, equipped: equipped)
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
    
}
