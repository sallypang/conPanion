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

class MyConcertsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        if let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") {
            let userFirebase = Firebase(url: "https://conpanion.firebaseio.com/users/" + (userID as! String) + "/events")
            userFirebase.observeSingleEventOfType(.Value, withBlock: { snapshot in
                var newEvents = [String]()
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? FDataSnapshot {
                    if let name = rest.value["url"] as? String {
                        newEvents.append(name)
                        print(name)
                    }
                }
                self.events = newEvents
                self.collectionView.reloadData()
            })
        }
    }
    
    // MARK: TableViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.events.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! MyEventCollectionViewCell
        let event  = self.events[indexPath.row]
        cell.urlLabel.text = event
        return cell
    }
}
