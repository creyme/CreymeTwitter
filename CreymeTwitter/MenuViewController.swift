//
//  MenuViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/22/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentUserImage: UIImageView!
     @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserScreenName: UILabel!
    
    
    
    // VARIABLES
    private var profileNavigationController: UIViewController!
    private var homeNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserImage.layer.cornerRadius = 4
        if User.currentUser?.profileUrl != nil {
            self.currentUserImage.setImageWith(URL(string: (User.currentUser?.profileUrl!)!)!)
        } else {
            currentUserImage.image = UIImage(named: "Twitter_logo_white_48.png")
        }
        currentUserName.text = User.currentUser?.name
        currentUserScreenName.text = User.currentUser?.screenname
        
        // TABLEVIEW SETTINGS
        tableView.delegate = self
        tableView.dataSource = self
        
        // UIVIEWCONTROLLERS SETTINGS
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "profileNavigationController")
        homeNavigationController = storyboard.instantiateViewController(withIdentifier: "tweetsNavigationController")
        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "mentionsNavigationController")
        
            // Add viewcontrollers to array
            viewControllers.append(profileNavigationController)
            viewControllers.append(homeNavigationController)
            viewControllers.append(mentionsNavigationController)
        
        // Set first view controller
        hamburgerViewController.contentViewController = homeNavigationController
        

        // Do any additional setup after loading the view.
    }

    
    // TABLEBIEW FUNCTIONS
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        let titles = ["My Profile", "Timeline", "Mentions"]
        
        cell.menuTitleLabel.text = titles[indexPath.row]

        return cell
    }
    
    // Did select cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        
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
