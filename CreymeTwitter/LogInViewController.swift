//
//  LogInViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/12/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class LogInViewController: UIViewController {

    @IBOutlet weak var twitterLogo: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        self.loginButton.layer.cornerRadius = 4
        self.loginButton.layer.borderWidth = 1.5
        
        
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
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        TwitterClient.sharedInstance?.login(success: {
            print("wow, login success!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
            
        }) { (error) in
            print("Login Button: \(error.localizedDescription)")
        }
        
       
        
        
    }
    
    
    
    

}



