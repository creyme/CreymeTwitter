//
//  DetailsViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/16/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController, UITextViewDelegate {
    
    // OUTLETS: Details
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
    
    
    // OUTLETS: Input
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetTextViewPlaceholder: UITextView!
    @IBOutlet weak var characterCounterLabel: UILabel!
    @IBOutlet weak var tweetSendButton: UIButton!
    @IBOutlet weak var tweetBarView: UIView!
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    @IBOutlet weak var replyToLabel: UIView!
    
    
    // VARIABLES
    var tweet: Tweet!
    var currentUser: User!
    var newTweet: Tweet!
    var keyboardConstant: CGFloat?
    
    
    // DEFAULT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        
        disableTweetButton()
        self.automaticallyAdjustsScrollViewInsets = false
        tweetTextViewPlaceholder.isHidden = false
        keyboardConstant = bottomContraint.constant
        
        // LOAD TWEET DETAILS
        loadTweetOwner()
        retweetedNameLabel.text = tweet.ownerScreenName
        
    
    // TWEETBAR SETTINGS
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
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
    
    
    // RETWEET BUTTON TAP
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
    

    // REPLY BUTTON TAP
    @IBAction func onReplyButton_Tap(_ sender: Any) {
        tweetTextView.becomeFirstResponder()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tweetTextView.resignFirstResponder()
    }

    
    // TWEET SEND
    @IBAction func onTweetSendButton(_ sender: Any) {
        if !tweetTextView.text.isEmpty && tweetTextView.text.characters.count <= 140 {
            // POST
            TwitterClient.sharedInstance?.replyTweet(text: tweetTextView.text, id: tweet.id, success: { (tweet) in
                self.tweet = tweet
                print("success reply")
                self.tweetTextView.resignFirstResponder()
                
            }, failure: { (error) in
                print("error reply")
            })
        }
    
    }

    

    
    
    // UI FUNCTIONS
    
    func disableTweetButton() {
        tweetSendButton.isEnabled = false
        tweetSendButton.layer.cornerRadius = 4
        tweetSendButton.layer.borderColor = UIColor.lightGray.cgColor
        tweetSendButton.layer.borderWidth = 1
        tweetSendButton.layer.backgroundColor = UIColor.clear.cgColor
        tweetSendButton.titleLabel?.textColor = UIColor.lightGray
        tweetSendButton.alpha = 0.5
    }
    
    func enableTweetButton() {
        tweetSendButton.isEnabled = true
        tweetSendButton.layer.cornerRadius = 4
        tweetSendButton.titleLabel?.textColor = UIColor.white
        tweetSendButton.layer.borderColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1).cgColor
        tweetSendButton.layer.borderWidth = 1
        tweetSendButton.layer.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1).cgColor
        tweetSendButton.alpha = 1
    }
    

    func textViewDidChange(_ textView: UITextView) {
        let spaces = NSCharacterSet.whitespacesAndNewlines
        let textViewChrCount = tweetTextView.text.characters.count
        characterCounterLabel.text = String(140 - textViewChrCount)
        
        if textViewChrCount >= 1 {
            tweetTextViewPlaceholder.isHidden = true
            characterCounterLabel.textColor = UIColor.lightGray
            enableTweetButton()
        }
        if textViewChrCount > 140 {
            characterCounterLabel.textColor = UIColor.red
            tweetTextViewPlaceholder.isHidden = true
            disableTweetButton()
        } else if tweetTextView.text.trimmingCharacters(in: spaces).isEmpty {
            characterCounterLabel.textColor = UIColor.lightGray
            tweetTextViewPlaceholder.isHidden = false
            disableTweetButton()
        } else  {
            characterCounterLabel.textColor = UIColor.lightGray
            tweetTextViewPlaceholder.isHidden = true
            enableTweetButton()
        }
        
    }


    // TWEETBAR FUNCTIONS
    
    func populateNewTweet() -> Tweet {
        let user = User(name: currentUser.name, screenname: currentUser.screenname, profileUrl: currentUser.profileUrl, tagline: currentUser.tagline)
        let tweet = Tweet(text: tweetTextView.text, timestamp: Date(), user: user)
        return tweet
    }
    
    func keyboardWillShow(_ notification : Notification) {
        let value = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let rect = value.cgRectValue
        self.bottomContraint.constant = rect.size.height
        
    }
    
    func keyboardWillHide(_ notification : Notification) {
        self.bottomContraint.constant = keyboardConstant!
        
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadTweetOwner() {
        
        
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
