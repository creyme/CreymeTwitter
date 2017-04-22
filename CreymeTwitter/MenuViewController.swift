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
    
    // VARIABLES
    private var profileNavigationController: UIViewController!
    private var homeNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TABLEVIEW SETTINGS
        tableView.delegate = self
        tableView.dataSource = self
        
        // UIVIEWCONTROLLERS SETTINGS
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        homeNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsViewController")
        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsViewController")
        
            // Add viewcontrollers to array
            viewControllers.append(profileNavigationController)
            viewControllers.append(homeNavigationController)
            viewControllers.append(mentionsNavigationController)
        

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
    
    /* Did select cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    */
    
    
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
