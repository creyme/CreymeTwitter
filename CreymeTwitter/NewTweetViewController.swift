//
//  NewTweetViewController.swift
//  CreymeTwitter
//
//  Created by CRISTINA MACARAIG on 4/16/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    // OUTLETS
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetTextViewPlaceholder: UITextView!
    @IBOutlet weak var characterCounterLabel: UILabel!
    @IBOutlet weak var tweetSendButton: UIButton!
    
    
    // DEFAULT
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI
        profileImageView.layer.cornerRadius = 4
        disableTweetButton()
        self.automaticallyAdjustsScrollViewInsets = false
        tweetTextViewPlaceholder.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // CANCEL
    @IBAction func onCancelTweetButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TWEET SEND
    @IBAction func onTweetSendButton(_ sender: Any) {
        if !tweetTextView.text.isEmpty && tweetTextView.text.characters.count <= 140 {
            // POST
        }
    }
    
    // UI FUNCTIONS
    
    func disableTweetButton() {
        tweetSendButton.isEnabled = false
        tweetSendButton.layer.cornerRadius = 4
        tweetSendButton.layer.borderColor = UIColor.lightGray.cgColor
        tweetSendButton.layer.borderWidth = 1
        tweetSendButton.layer.backgroundColor = UIColor.clear.cgColor
        tweetSendButton.titleLabel?.textColor = UIColor.lightGray
        tweetSendButton.alpha = 0.5
    }
    
    func enableTweetButton() {
        tweetSendButton.isEnabled = true
        tweetSendButton.layer.cornerRadius = 4
        tweetSendButton.titleLabel?.textColor = UIColor.white
        tweetSendButton.layer.borderColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1).cgColor
        tweetSendButton.layer.borderWidth = 1
        tweetSendButton.layer.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1).cgColor
        tweetSendButton.alpha = 1
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let spaces = NSCharacterSet.whitespacesAndNewlines
        let textViewChrCount = tweetTextView.text.characters.count
        characterCounterLabel.text = String(140 - textViewChrCount)
        
        if textViewChrCount >= 1 {
            tweetTextViewPlaceholder.isHidden = true
            enableTweetButton()
        }
        if textViewChrCount > 140 {
            characterCounterLabel.textColor = UIColor.red
            tweetTextViewPlaceholder.isHidden = true
            disableTweetButton()
        } else if tweetTextView.text.trimmingCharacters(in: spaces).isEmpty {
            tweetTextViewPlaceholder.isHidden = false
            disableTweetButton()
        } else  {
            characterCounterLabel.textColor = UIColor.lightGray
            tweetTextViewPlaceholder.isHidden = true
            enableTweetButton()
        }
        
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
