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

class MyConcertsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var jsonArray = [[String: AnyObject]]()
    
    var eventImages = [String]()
    var eventNames = [String]()
    var user: String!
    var eventUrls = [String]()
    
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
    
    // MARK: Private Functions
    func getUser() {
        if let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") {
            let userFirebase = Firebase(url: "https://conpanion.firebaseio.com/users/" + (userID as! String) + "/events")
            userFirebase.observeSingleEventOfType(.Value, withBlock: { snapshot in
                var newEvents = [String]()
                var newNames = [String]()
                var newURLS = [String]()
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? FDataSnapshot {
                    if let name = rest.value["imageString"] as? String {
                        newEvents.append(name)
                    }
                    if let eventName = rest.value["name"] as? String {
                        newNames.append(eventName)
                    }
                    if let eventURL = rest.value["url"] as? String {
                        newURLS.append(eventURL)
                    }
                }
                self.eventImages = newEvents
                self.eventNames = newNames
                self.eventUrls = newURLS
                self.collectionView!.reloadData()
            })
        }
    }
    
    
    @IBAction func deleteAction(sender: UIButton) {
        let deleteButton = sender as UIButton
        let index = deleteButton.tag
        self.eventImages.removeAtIndex(index)
        self.collectionView?.reloadData()
    }
    
    
    // MARK: TableViewDelegate
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.eventImages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! MyEventCollectionViewCell
        let event = self.eventImages[indexPath.row]
        let url = NSURL(string: event)!
        let data = NSData(contentsOfURL: url)
        cell.logoImageView.image = UIImage(data: data!)
        let eventName = self.eventNames[indexPath.row]
        cell.urlLabel.text = eventName
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = floor( (UIScreen.mainScreen().bounds.size.width - (2 + 1) * 10) / 2)
        return CGSizeMake(screenWidth, screenWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if let url = self.eventUrls[indexPath.row] as? String {
                let eventUrl = NSURL(string: url)
                UIApplication.sharedApplication().openURL(eventUrl!)
            }
        }

    }

}
