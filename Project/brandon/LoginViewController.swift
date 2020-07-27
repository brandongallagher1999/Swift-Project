//
//  LoginViewController.swift
//  Project
//
//  Created by Brandon Gallagher on 2020-07-14.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goToNotes", sender: self)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func push(_ sender: Any) {
        let email = String(emailField.text!)
        let password = String(passwordField.text!)
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if Auth.auth().currentUser != nil {
                self?.performSegue(withIdentifier: "goToNotes", sender: self)
            }
                        
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
