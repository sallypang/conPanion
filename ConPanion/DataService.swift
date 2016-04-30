//
//  DataService.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "https://conpanion.firebaseio.com/")
    private var _USER_REF = Firebase(url: "https://conpanion.firebaseio.com/users")
    private var _EVENT_REF = Firebase(url: "https://conpanion.firebaseio.com/events")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    var EVENT_REF: Firebase {
        return _EVENT_REF
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
}
