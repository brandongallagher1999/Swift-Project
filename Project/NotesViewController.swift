//
//  NotesViewController.swift
//  Project
//
//  Created by Michael Brownlow on 2020-07-21.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblNotes: UITableView!
    var array = ["why","won't","this","work","anymore"]
    
    let db = Firestore.firestore()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    //generate cells for table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Hello")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    //swipe to delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
            if editingStyle == .delete {
    
                // remove the item from the data model
                array.remove(at: indexPath.row)
    
                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
    
            } else if editingStyle == .insert {
                // Not used in our example, but if you were adding a new row, this is where you would do it.
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(array[indexPath.row])
    }
    
    @IBAction func btnCreate(_ sender: Any) {
        let createAlert = UIAlertController(title: "Add note", message: "Insert title and content", preferredStyle: .alert)
               
               createAlert.addTextField()
               createAlert.addTextField()
               
               let titleField = createAlert.textFields![0]
               let contentField = createAlert.textFields![1]
               
               let addButton = UIAlertAction(title: "Confirm", style: .default) { (action) in
                   
               
                   var ref : DocumentReference? = nil
                   ref = self.db.collection("notes").addDocument(data: [
                       "title" : titleField.text!,
                       "content" : contentField.text!
                   ]) {error in
                       if let error = error {
                           print("Error!")
                       } else{
                           print("Document Added Successfully!")
                       }
                   }
               }
               
        createAlert.addAction(addButton)
        present(createAlert, animated: true, completion: nil)
        
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
