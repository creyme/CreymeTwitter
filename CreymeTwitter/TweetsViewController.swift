//
//  TweetsViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // OUTLETS
    @IBOutlet weak var tableView: UITableView!

    // VARIABLES
    var tweets: [Tweet]!
    var tweetArray = [Tweet]()
    var tweetnum = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TABLEVIEW SETTINGS
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // LOGOUT
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




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetsCell", for: indexPath) as! TweetsCell
        
        // LOAD TWEETS
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
            
            self.tweets = tweets
            
            cell.tweet = self.tweets[indexPath.row]
            
            for tweet in tweets {
                self.tweetnum += 1
                print ("Tweet: \(self.tweetnum) \(tweet.text!)")
                print ("By: \(tweet.ownerName!)")
            }
            self.tableView.reloadData()
            
            
            
        }, failure: { (error) in
            print(error.localizedDescription)
        })
        
        
        
        
        
        return cell
        
    }
  
}

