//
//  ProfileViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/22/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

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
