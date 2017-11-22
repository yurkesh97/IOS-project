//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Mariana Sytnyk on 02.11.17.
//  Copyright © 2017 MS. All rights reserved.
//

import UIKit

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchField: UITextField!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userSurnameField: UITextField!
    @IBOutlet weak var userAgeField: UITextField!
    
    
    var users: [UserMO] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSource()
    }
    
    func loadDataSource() { 
        UserService.instance.deleteAllUsers()
        UserService.instance.downloadUsers() {
            self.users = UserService.instance.getAllUsers()
        }
        
        if let searchText = searchField.text, !searchText.isEmpty {
            users = UserService.instance.getAllUsers(searchText)
        } else {
            users = UserService.instance.getAllUsers()
        }
    }
    
    @IBAction func searchChanged(_ sender: Any) {
        loadDataSource()
    }
    
    
    @IBAction func addUser(_ sender: Any) {
        let name = userNameField.text ?? "No name"
        let surname = userSurnameField.text ?? "No surname"
        let age = Int(userAgeField.text ?? "0") ?? 0
        
        UserService.instance.addUser(name: name,
                                     surname: surname,
                                     age: age)
        loadDataSource()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return users.count
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "femaleCell") as? UserTVCell else {
            print ("Something wrong!")
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.nameLabel.text = (user.name ?? "Empty") + " " + (user.surname ?? "Empty")
        cell.ageLabel.text = "\(user.age )"
        return cell
        
    }
    
}

