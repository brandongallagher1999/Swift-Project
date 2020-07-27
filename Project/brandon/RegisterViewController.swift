//
//  RegisterViewController.swift
//  Project
//
//  Created by Brandon Gallagher on 2020-07-23.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
        let email = String(emailField.text!)
        let pwd = String(passwordField.text!)
        if(emailCheck())
        {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pwd){
                authResult, error in
                
                
                
            }
        }
    }
    
    func emailCheck() -> Bool
    {
        let email = String(emailField.text!)
        let pwd = String(passwordField.text!)
        let confirmed = String(confirmPassField.text!)
        if(email != "" && email.contains("@") && pwd != "" && confirmed == pwd)
        {
            return true
        }
        else
        {
            return false
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
