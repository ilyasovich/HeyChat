//
//  ViewController.swift
//  HeyChat
//
//  Created by Aman Ilyasovich on 5/25/20.
//  Copyright © 2020 Aman Ilyasovich. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        welcomeLabel.text = ""
        var charIndex = 0.0
        let titleText = C.appName
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.welcomeLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}

