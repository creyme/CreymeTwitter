//
//  ProfileViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/22/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

let offset_HeaderStop:CGFloat = 120 - 64  // At this offset the Header stops its transformations
let distance_W_LabelHeader:CGFloat = 30.0 // The distance between the top of the screen and the top of the White Label

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }

    @IBOutlet var headerView : UIView!
    @IBOutlet var headerLabel : UILabel!
    @IBOutlet var profileView : UIView!
    @IBOutlet var avatarImage: UIView!
    @IBOutlet var handleLabel : UILabel!
    @IBOutlet var blurBackgroundHolder: UIImageView!
    //@IBOutlet var headerBlurImageView: UIImageView!
    //@IBOutlet var headerImageView: UIImageView!
    @IBOutlet weak var backgroundImageConstraint: NSLayoutConstraint!
    
    
    // HEADER VARIABLES
    var tweet: Tweet!
    var currentUser: User!
    
    var isCurrentUser = true
    
    var headerBlurImageView: UIImageView?
    var headerImageView: UIImageView?
    //var blurBackgroundHolder: UIImageView?
    
    
    
    // DEFAULT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.isHidden = true
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)

        if isCurrentUser {
            navigationController?.navigationItem.leftBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
            
            loadCurrentUser()
        } else {
            navigationController?.navigationItem.leftBarButtonItem?.isEnabled = true
            loadTweetOwner()
        }
        
        
        // TABLEVIES SETTINGS
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // HEADER UI:
        avatarImage.layer.cornerRadius = 6
        profileImageView.layer.cornerRadius = 4
        
        
        // Header - Image
        self.headerImageView = UIImageView(frame: self.headerView.bounds)
       
        self.headerImageView?.contentMode = .scaleAspectFill
        self.headerView.insertSubview(self.headerImageView!, belowSubview: self.headerLabel)
        
        // Header - Blurred Image Holder
        self.blurBackgroundHolder = UIImageView(frame: self.headerView.bounds)
        
        self.blurBackgroundHolder?.contentMode = .scaleAspectFill
        self.headerView.insertSubview(self.blurBackgroundHolder!, belowSubview: self.headerLabel)
        
        // Header - Blurred Image
        self.headerBlurImageView = UIImageView(frame: self.headerView.bounds)
        headerBlurImageView?.alpha = 0.0
            if !isCurrentUser {
                self.headerImageView?.setImageWith(URL(string: tweet.backgroundImageUrl!)!)
                self.blurBackgroundHolder?.setImageWith(URL(string: tweet.backgroundImageUrl!)!)
                self.headerBlurImageView?.image = self.blurBackgroundHolder?.image?.blurredImage(withRadius: 40, iterations: 20, tintColor: UIColor.clear)
        }
 
        
        
        self.headerBlurImageView?.contentMode = .scaleAspectFill
        self.headerView.insertSubview(self.headerBlurImageView!, belowSubview: self.headerLabel)
 
        
        self.headerView.clipsToBounds = true
 
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
            
                    if currentUser.backgroundImageUrl != nil {
                        self.blurBackgroundHolder?.setImageWith(URL(string: currentUser.backgroundImageUrl!)!)
                        self.headerBlurImageView?.image = self.blurBackgroundHolder?.image?.blurredImage(withRadius: 40, iterations: 20, tintColor: UIColor.clear)

                    } else {
                        self.headerImageView?.image = UIImage(named: "Twitter_logo_white_48.png")
                
                        self.headerBlurImageView?.image = UIImage(named: "Twitter_logo_white_48.png")?.blurredImage(withRadius: 40, iterations: 20, tintColor: UIColor.clear)
            }
            
            self.headerView.clipsToBounds = true
            
            self.userFullNameLabel.text = currentUser.name
            self.headerLabel.text = currentUser.name
            self.userScreenNameLabel.text = "@\(currentUser.screenname ?? String())"
            self.descriptionLabel.text = currentUser.tagline
            self.locationLabel.text = currentUser.location
            self.followerCountLabel.text = "\(currentUser.followersCount)"
            self.followingCountLabel.text = "\(currentUser.followingCount)"
            

        }, failure: { (error) in
            print(error.localizedDescription)
        })
        
        
        
        
        }
    
    
    
   
    
    
    
    func loadTweetOwner() {
        print("loading tweet owner profile")
        
        if tweet.profileImageUrl != nil {
            self.profileImageView.setImageWith(URL(string: tweet.profileImageUrl!)!)
        } else {
            self.profileImageView.image = UIImage(named: "Twitter_logo_white_48.png")
        }
        if tweet.backgroundImageUrl != nil {
            self.headerImageView?.setImageWith(URL(string: tweet.backgroundImageUrl!)!)
            
            self.blurBackgroundHolder?.setImageWith(URL(string: tweet.backgroundImageUrl!)!)
            
            self.headerBlurImageView?.image = self.blurBackgroundHolder?.image?.blurredImage(withRadius: 40, iterations: 20, tintColor: UIColor.clear)
            
        } else {
            self.headerImageView?.image = UIImage(named: "Twitter_logo_white_48.png")
            self.blurBackgroundHolder?.image = UIImage(named: "Twitter_logo_white_48.png")
            self.headerBlurImageView?.image = UIImage(named: "Twitter_logo_white_48.png")?.blurredImage(withRadius: 40, iterations: 20, tintColor: UIColor.clear)
        }
        
        userFullNameLabel.text = tweet.ownerName
        headerLabel.text = tweet.ownerName
        userScreenNameLabel.text = "@\(tweet.ownerScreenName ?? String())"
        descriptionLabel.text = tweet.tagline
        locationLabel.text = tweet.location
        followerCountLabel.text = "\(tweet.followersCount )"
        followingCountLabel.text = "\(tweet.followingCount )"
        
        
        
        
    }

    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweeterProfileCell", for: indexPath) as! tweeterProfileCell
        
        return cell
    }
    
    
    
    // MARK: Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            
            // Hide views if scrolled super fast
            headerView.layer.zPosition = 0
            headerLabel.isHidden = true
            
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
            headerLabel.isHidden = false
            let alignToNameLabel = -offset + handleLabel.frame.origin.y + headerView.frame.height + offset_HeaderStop
            
            headerLabel.frame.origin = CGPoint(x: headerLabel.frame.origin.x, y: max(alignToNameLabel, distance_W_LabelHeader + offset_HeaderStop))
            
            
            //  ------------ Blur
            
            headerBlurImageView?.alpha = min (1.0, (offset - alignToNameLabel)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 9.4 // Slow down the animation
            print(avatarScaleFactor)
            
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            print(avatarSizeVariation)
            
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if avatarImage.layer.zPosition < headerView.layer.zPosition{
                    headerView.layer.zPosition = 0
                }
                
                
            }else {
                if avatarImage.layer.zPosition >= headerView.layer.zPosition{
                    headerView.layer.zPosition = 2
                }
                
            }
            
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        avatarImage.layer.transform = avatarTransform
        
        
        
        

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}

