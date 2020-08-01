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
    
    var segueTransfer = String()
    
    let db = Firestore.firestore()
    
    var notes = [String]()
    var documentIDs = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    //generate cells for table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        print(notes)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
    
    //swipe to delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
            if editingStyle == .delete {
    
                db.collection("notes").document(documentIDs[indexPath.row]).delete() { err in
                    if err != nil {
                        print("Error deleting")
                    }else{
                        print("Delete Successful!")
                        // remove the item from the data model
                        self.notes.remove(at: indexPath.row)
                        self.documentIDs.remove(at: indexPath.row)
                        
                        // delete the table view row
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
                
                
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueTransfer = documentIDs[indexPath.row]
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue" {
            
            let destinationController = segue.destination as! NoteDetailViewController
            destinationController.noteId = segueTransfer
        }
    }
    
    @IBAction func btnCreate(_ sender: Any) {
        let createAlert = UIAlertController(title: "Add note", message: "Insert title and content", preferredStyle: .alert)
               
               createAlert.addTextField()
               createAlert.addTextField()
               
               let titleField = createAlert.textFields![0]
               let contentField = createAlert.textFields![1]
               
               let addButton = UIAlertAction(title: "Confirm", style: .default) { (action) in
                   
                if titleField.text == ""
                {
                    //do nothing
                }
                else{
                   var ref : DocumentReference? = nil
                   ref = self.db.collection("notes").addDocument(data: [
                       "title" : titleField.text!,
                       "content" : contentField.text!,
                       "Uid" : "123456"
                   ]) {error in
                       if let error = error {
                           print("Error!")
                       } else
                       {
                            print("Document Added Successfully!")
                            self.notes.removeAll()
                            self.documentIDs.removeAll()
                            self.getNotesFromDB()
                       }
                   }
                }
               }
               
        createAlert.addAction(addButton)
        present(createAlert, animated: true, completion: nil)
        
    }
    
    func getNotesFromDB(){
        _ = db.collection("notes").getDocuments() { (querySnapshot, err) in
            if err != nil{
                print("Error getting documents")
            } else {
                for document in querySnapshot!.documents {
                    if let title = document.data()["title"] as? String {
                        print(title)
                        self.notes.append(title)
                        print(self.notes)
                    }
                    if document == document {
                        print(document.documentID)
                        self.documentIDs.append(document.documentID)
                    }
                    
                    
                }
                self.tblNotes.delegate = self
                self.tblNotes.dataSource = self
                self.tblNotes.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init")
        self.tblNotes.allowsSelectionDuringEditing = false
        getNotesFromDB()
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
