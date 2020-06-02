//
//  LoginViewController.swift
//  HeyChat
//
//  Created by Aman Ilyasovich on 5/25/20.
//  Copyright © 2020 Aman Ilyasovich. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: C.loginSegue, sender: self)
                }
            }
        }
    }
}
