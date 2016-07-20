//
//  Event+CoreDataProperties.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-27.
//  Copyright © 2016 Sally Pang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var name: String?
    @NSManaged var eventDesc: String?
    @NSManaged var id: String?
    @NSManaged var url: String?
    @NSManaged var image: String?
    @NSManaged var startLocal: String?
    @NSManaged var startTimezone: String?
    @NSManaged var resource_uri: String?
    
    func toAnyObject() -> [String: AnyObject] {
        return [
            "name": self.name!,
            "eventDesc":self.eventDesc!,
            "id": self.id!,
            "url": self.url!,
            "image": self.image!,
            "startLocal":self.startLocal!,
            "startTimezone":self.startTimezone!,
            "resource_uri":self.resource_uri!
        ]
    }

}
