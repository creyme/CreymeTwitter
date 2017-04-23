//
//  ProfileViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/22/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // HEADER OUTLETS: Details
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var bgImageViewView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // HEADER VARIABLES
    var tweet: Tweet!
    var currentUser: User!
    
    
    // DEFAULT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HEADER UI:
        bgImageViewView.layer.cornerRadius = 6
        profileImageView.layer.cornerRadius = 4
        
        loadCurrentUser()

    }
    
    // CURRENT USER FUNCTIONS
    func loadCurrentUser() {
        
        TwitterClient.sharedInstance?.currentAccount(success: { (currentUser) in
            self.currentUser = currentUser
            if currentUser.profileUrl != nil {
                self.profileImageView.setImageWith(URL(string: currentUser.profileUrl!)!)
            } else {
                self.profileImageView.image = UIImage(named: "Twitter_logo_white_48.png")
            }
            
            self.userFullNameLabel.text = currentUser.name
            self.userScreenNameLabel.text = "@\(currentUser.screenname ?? String())"
            self.descriptionLabel.text = currentUser.tagline
            self.locationLabel.text = currentUser.location
            self.followerCountLabel.text = String(describing: currentUser.followersCount) 
            self.followingCountLabel.text = String(describing: currentUser.followingCount) 
            

        }, failure: { (error) in
            print(error.localizedDescription)
        })
        
        
        

        
    }


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
