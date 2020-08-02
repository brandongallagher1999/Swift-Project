//
//  RegisterViewController.swift
//  Project
//
//  Created by Brandon Gallagher on 2020-07-23.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    var db = Firestore.firestore()

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var confirmPassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goToNotes", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
        let email = String(emailField.text!)
        let pwd = String(passwordField.text!)
        if(emailCheck())
        {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pwd){
                authResult, error in
                
                self.emailField.isHidden = true
                self.passwordField.isHidden = true
                self.confirmPassField.isHidden = true
                self.signUpButton.isHidden = true
                
                self.storeUserInfo()
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
    
    func storeUserInfo(){
        var ref : DocumentReference? = nil
        ref = self.db.collection("users").addDocument(data: [
            "email" : Auth.auth().currentUser?.email,
            "uid" : Auth.auth().currentUser?.uid
        ]) {error in
            if let error = error {
                print("Error!")
            } else
            {
                print("Document Added Successfully!")
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
