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
        self.getUser()
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
        let userFirebase = Firebase(url: "https://conpanion.firebaseio.com/users/" + userID + "/events")
        userFirebase.observeSingleEventOfType(.Value, withBlock: { snapshot in
            var newEvents = [String]()
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FDataSnapshot {
                if let name = rest.value["name"] as? String {
                    newEvents.append(name)
                }
            }
            self.events = newEvents
            self.tableView.reloadData()
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            let dict = self.events[indexPath.row]
//            print(dict)
//            let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
//            let userFirebase = Firebase(url: "https://conpanion.firebaseio.com/users/" + userID + "/events")
//            let profile = userFirebase.ref.childByAppendingPath(dict)
//            print(profile)
//            profile.removeValue()
        }
    }
}
