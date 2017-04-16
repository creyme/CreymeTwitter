//
//  Tweet.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    // STEP 1: ENUMERATE PROPERTIES: Variables for User details
    var tweetOwner = NSDictionary()
    var ownerName: String?
    var ownerScreenName: String?
    var profileImageUrl: URL?
    var textId: String?
    var text: String?
    var timestamp: Date?
    var isretweeted: Bool = false
    var retweetCount: Int = 0
    var isfavorite: Bool = false
    var favoritesCount: Int = 0
    var replyCount: Int = 0
    
    
    
    // STEP 2: DESERIALIZATION: Initialize value for user details or populate
    init(dictionary: NSDictionary) {
        
        tweetOwner = (dictionary["user"] as? NSDictionary)!
        
        ownerName = tweetOwner.value(forKeyPath: "name") as? String
        ownerScreenName = dictionary["screen_name"] as? String
        
        let imageURLString = tweetOwner.value(forKeyPath: "profile_image_url") as? String
        if imageURLString != nil {
            profileImageUrl = URL(string: imageURLString!)!
        } else {
            profileImageUrl = nil
        }
        
        textId = dictionary["id_str"] as? String
        text = dictionary["text"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
        isretweeted = (dictionary["retweeted"] as? Bool)!
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        isfavorite = (dictionary["favorited"] as? Bool)!
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
         }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            
        }
        
        return tweets
    }


}
