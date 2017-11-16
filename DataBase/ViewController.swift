 //
//  ViewController.swift
//  DataBase
//
//  Created by mac on 15.11.17.
//  Copyright © 2017 YurCom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedUser: LocationModel = LocationModel()
    var refresher: UIRefreshControl!
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle =  NSAttributedString(string: "Refresh")
        refresher.addTarget(self, action: #selector(ViewController.populate), for: UIControlEvents.valueChanged)
        listTableView.addSubview(refresher)
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
        // Get references to labels of cell
        myCell.textLabel!.text = String(describing: item)
        
        
        return myCell
    }
    
    @objc func populate() {
        
        
        refresher.endRefreshing()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
