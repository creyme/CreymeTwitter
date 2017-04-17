//
//  DetailsViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/16/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var retweetedNameLabel: UILabel!
    @IBOutlet weak var retweetedIconView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var replyCountIconButton: UIButton!
    @IBOutlet weak var replyCountLabel: UILabel!
    
    @IBOutlet weak var retweetCountIconButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeCountIconButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    // LOAD TWEET DETAILS
    var tweet: Tweet!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("CREYME: \(tweet.textId ?? String())")
        print(tweet.textId!)
        profileImageView.layer.cornerRadius = 4
        if tweet.profileImageUrl != nil {
            self.profileImageView.setImageWith(URL(string: tweet.profileImageUrl!)!)
        } else {
            self.profileImageView.image = UIImage(named: "Twitter_logo_white_48.png")
        }
        userFullNameLabel.text = tweet.ownerName
        userScreenNameLabel.text = "@\(tweet.ownerScreenName ?? String())"
        
        // calculate date since posted
        let from = tweet.timestamp
        let now = Date()
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .weekOfMonth])
        let calendar = Calendar.current
        let difference = calendar.dateComponents(components, from: from! as Date, to: now)
        let format = DateFormatter()
        format.dateFormat = "M/d/yy"
        let createdAt = format.string(from: from!)
        
        // logic to show date
        if difference.second! <= 0 {
            tweetDateLabel.text = "now"
        }
        if difference.second! > 0 && difference.minute! == 0 {
            tweetDateLabel.text = "\(difference.second!)s"
        }
        if difference.minute! > 0 && difference.hour! == 0 {
            tweetDateLabel.text = "\(difference.minute!)m"
        }
        if difference.hour! > 0 && difference.day! == 0 {
            tweetDateLabel.text = "\(difference.hour!)h"
        }
        if difference.day! > 0 && difference.weekOfMonth! == 0 {
            tweetDateLabel.text = "\(difference.day!)d"
        }
        if difference.weekOfMonth! > 0 {
            tweetDateLabel.text = "\(createdAt)"
        }
        
        tweetTextLabel.text = tweet.text
        tweetTextLabel.sizeToFit()
        
        let isretweet = tweet.isretweeted
        if isretweet {
            retweetCountIconButton.setImage(UIImage(named: "retweet-action-on.png"), for: .normal)
        } else {
           retweetCountIconButton.setImage(UIImage(named: ""), for: .normal)
        }
        retweetCountLabel.text = String(tweet.retweetCount)
        
        let islike = tweet.isfavorite
        if islike {
            likeCountIconButton.setImage(UIImage(named: "like-action-on.png"), for: .normal)
        } else {
            likeCountIconButton.setImage(UIImage(named: ""), for: .normal)
        }
        likeCountLabel.text = String(tweet.favoritesCount)
        
        
        }
    
    
    // LIKE BUTTON TAP
    @IBAction func onLikeButton_Tap(_ sender: Any) {
        
        if tweet.isfavorite == false {
            
            TwitterClient.sharedInstance?.likeTweet(id: tweet.id, success: { (tweet) in
                // process like
                self.tweet = tweet
                self.tweet.isfavorite = true
                self.likeCountIconButton.setImage(UIImage(named: "like-action-on.png"), for: .normal)
                let newCount = Int(self.likeCountLabel.text!)
                self.likeCountLabel.text = String(newCount! + 1)
            }, failure: { (error) in
                print("error like")
            })
            } else {
            TwitterClient.sharedInstance?.unlikeTweet(id: tweet.id, success: { (tweet) in
                // process unlike
                self.tweet = tweet
                self.tweet.isfavorite = false
                self.likeCountIconButton.setImage(UIImage(named: ""), for: .normal)
                let newCount = Int(self.likeCountLabel.text!)
                self.likeCountLabel.text = String(newCount! - 1)
            }, failure: { (error) in
                print("error unlike")
            })
        }
    }
       
    @IBAction func onRetweetButton_Tap(_ sender: Any) {
        
        if tweet.isretweeted == false {
            
            TwitterClient.sharedInstance?.reTweet(id: tweet.id, success: { (tweet) in
                // process retweet
                self.tweet = tweet
                self.tweet.isretweeted = true
                self.retweetCountIconButton.setImage(UIImage(named: "retweet-action-on.png"), for: .normal)
                let newCount = Int(self.retweetCountLabel.text!)
                self.retweetCountLabel.text = String(newCount! + 1)
            }, failure: { (error) in
                print("error retweet")
            })
        }
    }
    

    @IBAction func onReplyButton_Tap(_ sender: Any) {
    }
    
    
    

        // Do any additional setup after loading the view.


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
