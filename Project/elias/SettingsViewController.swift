//
//  SettingsViewController.swift
//  Project
//
//  Created by Elias Aguilera Yambay on 2020-07-30.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var myTableView: UITableView!
      let developers = ["App Deloped By:","Brandon", "Mike", "Elias"]
        
          override func viewDidLoad() {
              super.viewDidLoad()
              // Do any additional setup after loading the view.
              myTableView.delegate = self
              myTableView.dataSource = self
              
          }
        
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                   return developers.count
              }
              
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath)
                
                   cell.textLabel?.text = developers[indexPath.row]
    
                   return cell
        
    }
        
    }
    
