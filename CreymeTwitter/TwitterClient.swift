//
//  TwitterClient.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    // AUTHORIZE
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!,
                                       consumerKey: "AN5GCcUKmIERIBOlE3J1W7n2Q",
                                       consumerSecret: "KwlyZaITvbfvxYniVpBtqH8mQM1vWDhBezd530lbGgELHebvqy")
    
    // VARIABLES
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    // LOGIN
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "/oauth/request_token", method: "GET", callbackURL: URL(string: "CreymeTwiiter://oauth"), scope: nil, success: { (requestToken) in
            print(requestToken?.token ?? String())
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token ?? String())")!
            
            UIApplication.shared.open(url)
            
            
        }, failure: { (error) in
            print("error: \(error?.localizedDescription ?? String())")
            self.loginFailure?(error! as NSError)
        })

        
    }
    
    
    // HANDLE URL
    func handleOpenUrl(url: NSURL) {
    
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        // REQUEST TOKEN
        fetchAccessToken(withPath: "oauth/access_token", method: "POST",
                         requestToken: requestToken,
                         success: { (accessToken:BDBOAuth1Credential?) in
                                    
                            print("I got the token")
                            
                            self.currentAccount(success: { (user:User) in
                                
                                User.currentUser = user
                                self.loginSuccess?()
                                
                            }, failure: { (error: NSError) in
                                self.loginFailure?(error)
                            })
                      
        }, failure: { (error: Error?) in
            
                            print("error: \(error?.localizedDescription ?? String())")
                            self.loginFailure?(error! as NSError)
        })    
    }
    
    
    
    // GET USER INFO
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        
        
        get("1.1/account/verify_credentials.json",
            parameters: nil,
            progress: nil,
            success: { (task: URLSessionDataTask, response:Any?) in
            
            // Get response
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
                
                success(user)
            
            print("name: \(user.name!)")
            print("screenname: \(user.screenname!)")
            print("profile url: \(user.profileUrl!)")
            print("description: \(user.tagline!)")
            
        }, failure: { (task:URLSessionDataTask?, error:Error) in
            failure(error as NSError)
            
            print("error: \(error.localizedDescription)")
        })
    }
    
    
    
    
    // GET TWEETS
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        
        get("1.1/statuses/user_timeline.json",
            parameters: nil,
            progress: nil,
            success: { (task:URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
                
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            print("error getting tweets")
            failure(error as NSError)
            
        })
 
    }
    

}
