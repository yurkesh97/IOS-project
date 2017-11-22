//
//  userDTO.swift
//  MyFirstApp
//
//  Created by mac on 16.11.17.
//  Copyright © 2017 MS. All rights reserved.
//

import Foundation
import ObjectMapper

class UserDTO: Mappable {   //Йде присвоєння даних з бази даних по ключам локальним змінним
    
    var name: String? = nil
    var surname: String? = nil
    var age: String? = nil
    
    required init (map : Map) {
        
    }
    func mapping(map: Map) {
        name <- map["Name"]
        surname <- map["Surname"]
        age <- map["Age"]
    }
}
