//
//  TransNavViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/22/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class TransNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize Appearance
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationBar.tintColor = .white
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barStyle = .black
        self.navigationBar.isTranslucent = true
    }
}
