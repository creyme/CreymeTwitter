//
//  MainNavViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/15/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class MainNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize Appearance
        self.navigationBar.barTintColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationBar.tintColor = .white
        self.navigationBar.barStyle = .blackOpaque
        
        
        
               
    }

}
