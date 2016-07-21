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
import Alamofire
import SwiftyJSON

class MyConcertsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var jsonArray = [[String: AnyObject]]()
    
    var events = [String]()
    var user: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUser()
        self.getData("https://www.eventbriteapi.com/v3/events/26642915678/?token=VWJN3AO6RDJXBQBDOT7U")
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
    
    
    // MARK: Private Functions
    func getData(url: String) {
        Alamofire.request(.GET, url) .responseJSON { response in
            if ((response.result.value) != nil) {
                let jsonVar = JSON(response.result.value!)
                self.jsonArray = jsonVar["logo"].arrayObject as! [[String: AnyObject]]
                
                for item in self.jsonArray {
                    let eventImage = item["url"]
                    print(eventImage, "event image")
                }
                
            }
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
        cell.urlLabel.text = self.events[indexPath.row]
        return cell
    }
}
