//
//  HomeViewController.swift
//  Project
//
//  Created by Elias Aguilera Yambay on 2020-07-30.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SettigsButton: UIButton!
    @IBOutlet weak var LocationButton: UIButton!
    
    @IBAction func LoginSegue(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: LoginButton)
    }
    
    
    @IBAction func blueButton(_ sender: Any) {
        LoginButton.backgroundColor = .blue
        SettigsButton.backgroundColor = .blue
        LocationButton.backgroundColor = .blue
    }
    
    @IBAction func PurpleButton(_ sender: Any) {
        LoginButton.backgroundColor = .purple
        SettigsButton.backgroundColor = .purple
        LocationButton.backgroundColor = .purple
    }
    

    @IBAction func RedButton(_ sender: Any) {
        LoginButton.backgroundColor = .red
        SettigsButton.backgroundColor = .red
        LocationButton.backgroundColor = .red
    }
    
    
    
    @IBAction func BlackButton(_ sender: Any) {
        LoginButton.backgroundColor = .black
        SettigsButton.backgroundColor = .black
        LocationButton.backgroundColor = .black
    }
    
    
    @IBAction func OrangeButton(_ sender: Any) {
        LoginButton.backgroundColor = .orange
        SettigsButton.backgroundColor = .orange
        LocationButton.backgroundColor = .orange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
