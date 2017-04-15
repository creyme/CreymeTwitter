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
            
            //userFullNameLabel.text =
            
        }
        
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
