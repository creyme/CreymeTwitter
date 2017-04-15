//
//  TweetsViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    // OUTLETS
    
    
    
    
    // VARIABLES
    var tweets: [Tweet]!
    var tweetnum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
            
            self.tweets = tweets
            
            for tweet in tweets {
                self.tweetnum += 1
                print ("tweet \(self.tweetnum) \(tweet.text!)")
            }
            
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(_ sender: Any) {
        
    TwitterClient.sharedInstance?.logout()
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
