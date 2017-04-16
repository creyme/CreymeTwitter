//
//  TweetsCell.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/14/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {

    // OUTLETS
    @IBOutlet weak var retweetedNameLabel: UILabel!
    @IBOutlet weak var retweetedIconView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var replyCountIconView: UIImageView!
    @IBOutlet weak var replyCountLabel: UILabel!
    
    @IBOutlet weak var retweetCountIconView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeCountIconView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    
    
    var tweet: Tweet! {
        didSet {
            
            if tweet.profileImageUrl != nil {
                profileImageView.setImageWith(tweet.profileImageUrl!)
            } else {
                profileImageView.image = UIImage(named: "Twitter_logo_white_48.png")
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
            
            let isretweet = tweet.isretweeted
                if isretweet {
                    retweetCountIconView.image = UIImage(named: "retweet-action-on.png")
                } else {
                    retweetCountIconView.image = UIImage(named: "retweet-action.png")
            }
            retweetCountLabel.text = String(tweet.retweetCount)
            
            let islike = tweet.isfavorite
            if islike {
                likeCountIconView.image = UIImage(named: "like-action-on.png")
            } else {
                likeCountIconView.image = UIImage(named: "like-action.png")
            }
            likeCountLabel.text = String(tweet.favoritesCount)
            
            
            
            
            
        }
        
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 4
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
