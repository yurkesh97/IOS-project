//
//  UserService.swift
//  MyFirstApp
//
//  Created by Mariana Sytnyk on 14.11.17.
//  Copyright © 2017 MS. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import AlamofireObjectMapper

class UserService {
    
    static let instance = UserService()
    private init() { }
    
    let moc: NSManagedObjectContext = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        return delegate.persistentContainer.viewContext
    } ()
    
    func addUser(name: String, surname: String, age: Int) {
        guard let mo = NSEntityDescription.insertNewObject(forEntityName: "UserMO", into: moc) as? UserMO else {
            return
        }
        
        mo.name = name
        mo.surname = surname
        mo.age = Int64(age)
        
        saveContext()
    }
    
    func addUsers(count: Int) {
        for _ in 0 ..< count {
            let _ = NSEntityDescription.insertNewObject(forEntityName: "UserMO", into: moc)
            
        }
        saveContext()
    }
    
    func saveContext() {
        do {
            try moc.save()
        } catch {
            return
        }
    }
    
    func deleteAllUsers() { //Видаляє всіх юзерів
        let fetchRequest = NSFetchRequest<UserMO>(entityName: "UserMO")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try moc.execute(deleteRequest)
        } catch {
            return
        }
    }
    
    func getAllUsers(_ nameBegin: String? = nil) -> [UserMO] { //Дістає
        
        let fetchRequest = NSFetchRequest<UserMO>(entityName: "UserMO")
        //let predicate: NSPredicate = NSPredicate(format: "age > %d", 22)
        //fetchRequest.predicate = predicate
        let ageSort = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [ageSort]
        
        if let begin = nameBegin {
            let predicate: NSPredicate = NSPredicate(format: "name BEGINSWITH %@", begin)
            fetchRequest.predicate = predicate
        }
        
        var users: [UserMO] = []
        
        do {
            users = try moc.fetch(fetchRequest)
        } catch {
            return users
        }
        
        return users
    }
    
    func downloadUsers(completion: (()-> ())? = nil) { //Завантажує базу даних і зберігає її у форматі String
        guard let url: URL = URL(string: "http://userski.zzz.com.ua/users.php") else {
            return
        }
        let request = Alamofire.request(url)    //Конфертує дані в String до яких можна доступатись по ключах
        request.responseString { (dataResponse) in
            print (dataResponse.result.value ?? "No data")
        }
        
        
        request.responseArray { (responce: DataResponse<[UserDTO]>) in
            
            let users = responce.result.value //Вивожу дані по ключах на екран 
            
            for user in users ?? [] {
                guard let name = user.name else {continue}
                guard let surname = user.surname else {continue}
                guard let age = Int(user.age ?? "0") else {continue}
                
                self.addUser(name: name, surname: surname, age: age)
            }
            
            completion?()
            print(users?.count)
        }
    }
    
}
