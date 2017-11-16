//
//  LocationModel.swift
//  DataBase
//
//  Created by mac on 15.11.17.
//  Copyright © 2017 YurCom. All rights reserved.
//

import UIKit

class LocationModel: NSObject {
    
    var name: String?
    var surname: String?
    var age: String?
    
    override init() {
        
    }
    
    init(name: String, surname: String, age: String) {
        self.name = name
        self.surname = surname
        self.age = age
    }
    
    override var description: String{
        return "Name: \(name!), Surname: \(surname!), Age: \(age!)"
    }

}
