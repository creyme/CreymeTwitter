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
        
        let client = TwitterClient.sharedInstance
        
        client?.login(success: {
            print("wow, login success!")
            
            
        }) { (error) in
            print("error: \(error.localizedDescription)")
        }
        
       
        
        
    }
    
    
    
    

}
