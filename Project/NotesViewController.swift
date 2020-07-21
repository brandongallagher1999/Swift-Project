//
//  NotesViewController.swift
//  Project
//
//  Created by Michael Brownlow on 2020-07-21.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblNotes: UITableView!
    let array = ["why","won't","this","work","anymore"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Hello")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    @IBAction func btnCreate(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init")
        tblNotes.delegate = self
        tblNotes.delegate = self
        tblNotes.dataSource = self
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
