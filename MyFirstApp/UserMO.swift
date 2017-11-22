//
//  UserMO+CoreDataClass.swift
//  MyFirstApp
//
//  Created by Mariana Sytnyk on 14.11.17.
//  Copyright © 2017 MS. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserMO)
public class UserMO: NSManagedObject {  
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var age: Int64
}
