//
//  TweetsViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewTweetViewControllerDelegate, UIScrollViewDelegate {

    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    

    // VARIABLES
    var tweets: [Tweet]!
    var tweetArray: Tweet!
    var currentTweetDetails: Tweet!
    var offset = 0
    var lastTweetId = 0
    var refreshControl: UIRefreshControl!
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    
    // DEFAULT FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI
        //self.twitterLogo()
        let twitterLogo = UIImage(named: "Twitter_logo_white_48.png")
        let logoImage = UIImageView(image: twitterLogo)
        logoImage.frame.size.width = 32
        logoImage.frame.size.height = 32
        logoImage.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImage
        
        // LOAD TWEETS
        loadTweets()
        
        // TABLEVIEW SETTINGS
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // REFRESH SETTINGS
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // INFINITE SCROLL
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // LOGOUT
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
    // LAUNCH FUNCTIONS
    func twitterLogo() {
        
        // BG
        let bgLayer = UIView()
        bgLayer.frame = self.view.frame
        bgLayer.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1)
        self.view.addSubview(bgLayer)
        
            // Twitter
            let logo = UIImageView()
            logo.image = UIImage(named: "Twitter_Logo_White_On_Image.png")
            logo.frame.size.width = 100
            logo.frame.size.height = 100
            logo.center = view.center
            bgLayer.addSubview(logo)
        
        let window = UIApplication.shared.keyWindow
        _ = window!.convert(bgLayer.frame, from: view)
        window!.addSubview(bgLayer)

        // Transform
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveLinear, animations: {
            logo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: 0.5, animations: { 
                    logo.transform = CGAffineTransform(scaleX: 20, y: 20)
                    UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
                        bgLayer.alpha = 0
                    }, completion: nil)
                })
            }
        }
        
    }
    

    // REFRESH FUNCTIONS
    func onRefresh() {
        print("onRefresh")
        // LOAD TWEETS
        TwitterClient.sharedInstance?.homeTimeline(offset: offset, success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }
    
    
    // LOAD TWEETS
    func loadTweets() {
        TwitterClient.sharedInstance?.homeTimeline(offset: offset, success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            for i in tweets {
                print (i.id)
            }
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    
    
    
    // LOAD MORE
    func loadMore() {
        offset += 20
        let lastTweet = tweets.last!
        lastTweetId = lastTweet.id - 1
        print(lastTweetId)
        TwitterClient.sharedInstance?.loadMoreHomeTimeline(offset: offset, lastTweet: lastTweetId, success: { (tweets) in
            
            // Update flag
            self.isMoreDataLoading = false
            
            // Stop the loading indicator
            self.loadingMoreView!.stopAnimating()
            
            // ... Use the new data to update the data source ...
            self.tweets! += tweets
            
            // Stop the loading indicator

            self.tableView.reloadData()

        }, failure: { (error) in
            print(error.localizedDescription)
        })

    }
    
    
    // INFINITESCROLL FUNCTIONS
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
    
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = self.tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // Load more:
                loadMore()
                
            }
        }
    }
    
    
    // TABLEVIEW FUNCTIONS
    func newTweetViewControllerDelegateCreatedTweet(tweet: Tweet) {
        tweets.insert(tweet, at: 0)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetsCell", for: indexPath) as! TweetsCell
        cell.tweet = self.tweets[indexPath.row]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToUserProfile(_:)))
        tap.numberOfTapsRequired = 1
        cell.profileImageView.isUserInteractionEnabled = true
        cell.profileImageView.addGestureRecognizer(tap)
        // assign indexes of buttons
        cell.profileImageView.tag = indexPath.row
        
        return cell
    }
    
    func goToUserProfile(_ sender: UITapGestureRecognizer) {
        print("tapped tweet owner image")
        //performSegue(withIdentifier: "tweetOwnerProfilesNavSegue", sender: sender)
        //shouldPerformSegue(withIdentifier: "tweetOwnerProfilesNavSegue", sender: sender)
    
        
        
        /*if let indexPath = tableView.indexPathForSelectedRow {
            tweetArray = self.tweets[indexPath.row]
            print(tweetArray.ownerName ?? String())*/
            
            //let tweeterProfile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            //self.navigationController?.pushViewController(tweeterProfile, animated: true)
            performSegue(withIdentifier: "tweetOwnerProfilesNavSegue", sender: sender)
            
    }

    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "newTweetSegue" {
            let destination = segue.destination as! UINavigationController
            let vc = destination.topViewController as! NewTweetViewController
            vc.newTweetViewControllerDelegate = self
            
        } else if segue.identifier == "detailsTweetSegue" {
            let destination = segue.destination as! DetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
            destination.tweet = self.tweets[indexPath.row]
            }
            
        } else if segue.identifier == "tweetOwnerProfilesNavSegue" {
            let tap = sender as! UITapGestureRecognizer
            let cell = tap.view?.superview?.superview as! TweetsCell
            let indexPath = tableView.indexPath(for: cell)
            let tweeterProfile = tweets[indexPath!.row]

            let destination = segue.destination as! UINavigationController
            let vc = destination.topViewController as! ProfileViewController
                print("tweetOwnerProfilesSegue")
                vc.tweet = tweeterProfile
                vc.isCurrentUser = false

        }
     }
    
    
    
    
}

