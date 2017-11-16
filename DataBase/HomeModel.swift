//
//  HomeModel.swift
//  DataBase
//
//  Created by mac on 15.11.17.
//  Copyright © 2017 YurCom. All rights reserved.
//

import UIKit
import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
    
   weak var delegate: HomeModelProtocol!
    
    var date = Data()

    let urlPath: String = "http://userski.zzz.com.ua/users.php"
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let users = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let user = LocationModel()
            
            if  let name = jsonElement["Name"] as? String,
                let surname = jsonElement["Surname"] as? String,
                let age = jsonElement["Age"] as? String
            {
                user.name = name
                user.surname = surname
                user.age = age
            }
            
            users.add(user)
            
            
        }
      
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: users)
            
        })
    }
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
}
