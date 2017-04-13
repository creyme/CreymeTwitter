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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        
        
        
        // Set API Keys
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "AN5GCcUKmIERIBOlE3J1W7n2Q", consumerSecret: "KwlyZaITvbfvxYniVpBtqH8mQM1vWDhBezd530lbGgELHebvqy")
       
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "/oauth/request_token", method: "GET", callbackURL: URL(string: "CreymeTwiiter://oauth"), scope: nil, success: { (requestToken) in
            print(requestToken?.token ?? String())
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token ?? String())")!
            
            UIApplication.shared.open(url)
            
            
        }, failure: { (error) in
            print("error: \(error?.localizedDescription ?? String())")
        })
        
        
    }
    
    
    
    

}
