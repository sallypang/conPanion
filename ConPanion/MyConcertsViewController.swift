//
//  MyConcertsViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class MyConcertsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var events = [String]()
    var user: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.getUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Find user
    func getUser() {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let userFirebase = Firebase(url: "https://conpanion.firebaseio.com/users" + userID + "/events")
        print(userFirebase)
        userFirebase.observeSingleEventOfType(.Value, withBlock: { snapshot in
            print(snapshot.childrenCount)
        })
    }
    
    // MARK: TableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! MyEventTableViewCell
        cell.urlLabel.text = self.events[indexPath.row]
        
        return cell
    }
}