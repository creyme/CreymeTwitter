//
//  User.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class User: NSObject {


    
    // STEP 1: ENUMERATE PROPERTIES: Variables for User details
    static var _currentUser: User?
    static let userDidLogoutNotification = "UserDidLogout"
    var dictionary: NSDictionary?
    
    var name: String?
    var screenname: String?
    var profileUrl: String?
    var tagline: String?
    var location: String?
    var tweetCount: Int = 0
    var followersCount: Int = 0
    var followingCount: Int = 0
    
    
    
    // STEP 2: DESERIALIZATION: Initialize value for user details or populate
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        
        screenname = dictionary["screen_name"] as? String
        
        profileUrl = dictionary["profile_image_url_https"] as? String
        
        tagline = dictionary["description"] as? String
        
        location = dictionary["location"] as? String
        
        tweetCount = (dictionary["statuses_count"] as? Int) ?? 0
        
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        
    }
    
    init(name: String?, screenname: String?, profileUrl: String?, tagline: String?) {
        self.name = name
        self.screenname = screenname
        self.profileUrl = profileUrl
        self.tagline = tagline
    }
    
    
    
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
            
                defaults.set(data, forKey: "currentUserData")
                
            } else {
                
                defaults.set(nil, forKey: "currentUserData")
                
            }
            
            defaults.synchronize()
            
        }
    
    }
    

}
