//
//  Schema.swift
//  SchemaColor
//
//  Created by Rome Rock on 2/22/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import Foundation
class Schema: NSObject, NSCoding {
    // MARK: - Types
    
    enum CoderKeys: String {
        case schemaNameKey
        case schemaPrimaryColorKey
        case schemaSecondaryColorKey
        case schemaIsFreeKey
    }
    
    // MARK: - Properties
    
    let name:String
    let primaryColor:String
    let secondaryColor:String
    let isFree:Bool
    
    // MARK: - Initializers
    
    init(name:String, primaryColor:String, secondaryColor:String, isFree:Bool) {
        self.name = name
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.isFree = isFree
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: CoderKeys.schemaNameKey.rawValue) as! String
        primaryColor = aDecoder.decodeObject(forKey: CoderKeys.schemaPrimaryColorKey.rawValue) as! String
        secondaryColor = aDecoder.decodeObject(forKey: CoderKeys.schemaSecondaryColorKey.rawValue) as! String
        isFree = aDecoder.decodeObject(forKey: CoderKeys.schemaIsFreeKey.rawValue) as! Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CoderKeys.schemaNameKey.rawValue)
        aCoder.encode(primaryColor, forKey: CoderKeys.schemaPrimaryColorKey.rawValue)
        aCoder.encode(secondaryColor, forKey: CoderKeys.schemaSecondaryColorKey.rawValue)
        aCoder.encode(isFree, forKey: CoderKeys.schemaIsFreeKey.rawValue)
    }
}
