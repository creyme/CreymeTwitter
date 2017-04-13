//
//  User.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class User: NSObject {

// DESERIALIZATION ********************************
    
    // PROPERTIES: Variable for User details
    var name: String?
    var screenname: String?
    var profileUrl: NSURL?
    var tagline: String?
    
    // Initialize value for user details or populate
    init(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
    }
    
    

}
