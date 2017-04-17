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
            print("LOGIN: \(error?.localizedDescription ?? String())")
            self.loginFailure?(error! as NSError)
        })
    }

    
    // LOGOUT
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
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
            
                            print("REQUEST TOKEN: \(error?.localizedDescription ?? String())")
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
            
            print("GET USER INFO: \(error.localizedDescription)")
        })
    }
    
    
    
    
    // GET TWEETS
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/statuses/home_timeline.json",
            parameters: nil,
            progress: nil,
            success: { (task:URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
                
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            print("GET TWEETS: error getting tweets")
            failure(error as NSError) 
        })
    }
    
    
    // POST TWEET
    func postTweet(_ tweetText: String!, inReplyToStatusId: String?, completion: @escaping (Bool) -> Void) {
        
        var parameters: [String:String] = ["status":tweetText]
        if let inReplyToStatusId = inReplyToStatusId {
            parameters["in_reply_to_status_id_str"] = inReplyToStatusId
        }
        
        post("1.1/statuses/update.json", parameters: parameters, progress: nil, success: { (task, response) in
            completion(true)
        }) { (task, error) in
            print("POST TWEET: \(error.localizedDescription)")
        }
    }
    
    // FAVORITES-LIKE
    func likedTweet(_ textId: Int, success: @escaping (Tweet) -> (), failure: @escaping (NSError) -> ()) {
    let parameters = ["id_str": textId]
        
        post("1.1/favorites/create.json", parameters: parameters, progress: nil, success: { (task, response) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            success(tweet)
        }) { (task, error) in
            print("LIKE: \(error.localizedDescription)")
            failure(error as NSError)
        }
    }
    
    // UNFAVORITE-UNLIKE
    func unlikedTweet(_ textId: Int, success: @escaping (Tweet) -> (), failure: @escaping (NSError) -> ()) {
        let parameters = ["id_str": textId]
        
        post("1.1/favorites/destroy.json", parameters: parameters, progress: nil, success: { (task, response) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            success(tweet)
        }) { (task, error) in
            print("UNLIKE: \(error.localizedDescription)")
            failure(error as NSError)
        }
    }

    
    // RETWEET
    func reTweet(_ textId: Int, success: @escaping (Tweet) -> (), failure: @escaping (NSError) -> ()) {
        
        post("1.1/statuses/retweet/\(textId).json", parameters: nil, progress: nil, success: { (task, response) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            success(tweet)
        }) { (task, error) in
            print("RETWEET: \(error.localizedDescription)")
            failure(error as NSError)
        }
    }
    
    // UNRETWEET/UNTWEET
    func unTweet(_ textId: Int, success: @escaping (Tweet) -> (), failure: @escaping (NSError) -> ()) {
        
        post("1.1/statuses/unretweet/\(textId).json", parameters: nil, progress: nil, success: { (task, response) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            success(tweet)
        }) { (task, error) in
            print("RETWEET: \(error.localizedDescription)")
            failure(error as NSError)
        }
    }


    
    
    
    
    
    
}
