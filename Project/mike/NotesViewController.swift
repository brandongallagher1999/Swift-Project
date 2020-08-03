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
import FirebaseAuth

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblNotes: UITableView!
    
    var segueTransfer = String()
    
    //FirebaseAuth and Database Variables
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    //Used to store the Note titles and DocumentIDs
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
        
        //Set the text label to the title of each note
        cell.textLabel?.text = notes[indexPath.row]
        
        return cell
    }
    
    //swipe to delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
            if editingStyle == .delete {
    
                //Delete the note based on their document ID of the swiped row.
                db.collection("notes").document(documentIDs[indexPath.row]).delete() { err in
                    if err != nil {
                        print("Error deleting")
                    }else{
                        print("Delete Successful!")
                        // remove the note and the ID from both arrays
                        self.notes.remove(at: indexPath.row)
                        self.documentIDs.remove(at: indexPath.row)
                        
                        // delete the table view row
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tranfer the document ID from the selected row
        segueTransfer = documentIDs[indexPath.row]
        
        //segue to the details view
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //attach the variable to the segue
        if segue.identifier == "segue" {
            
            let destinationController = segue.destination as! NoteDetailViewController
            destinationController.noteId = segueTransfer
        }
    }
    
    @IBAction func btnCreate(_ sender: Any) {
        //alert for creating a note
            let createAlert = UIAlertController(title: "Add note", message: "Insert title and content", preferredStyle: .alert)
               
            createAlert.addTextField()
            createAlert.addTextField()
               
            let titleField = createAlert.textFields![0]
            let contentField = createAlert.textFields![1]
               
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            let addButton = UIAlertAction(title: "Confirm", style: .default) { (action) in
                   
            if titleField.text == ""
            {
                //do nothing if the title is blank
            }
            else{
                var ref : DocumentReference? = nil
                let uidArray : [String] = [self.user!.uid]
                
                //write to the database of the inputted data and the user's uid in an array object to be able to add to
                ref = self.db.collection("notes").addDocument(data: [
                    "title" : titleField.text!,
                    "content" : contentField.text!,
                    "Uid" : uidArray
                ]) {error in
                    if error != nil {
                        print("Error!")
                    } else
                    {
                        //refresh the table with the newly created note
                        print("Document Added Successfully!")
                        self.notes.removeAll()
                        self.documentIDs.removeAll()
                        self.getNotesFromDB()
                    }
                }
            }
        }
               
        //add the create action and the cancel action
        createAlert.addAction(addButton)
        createAlert.addAction(cancelButton)
        
        //present alert
        present(createAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnHome(_ sender: Any) {
        //transition and set key to the home view
        let transition = storyboard?.instantiateViewController(identifier: constants.storyboardIDs.HomeController) as? HomeViewController
        view.window?.rootViewController = transition
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func btnRefresh(_ sender: Any) {
        //refresh the table by removing everything from the arrays and table
        self.notes.removeAll()
        self.documentIDs.removeAll()
        self.getNotesFromDB()
    }
    
    
    func getNotesFromDB(){
        //get all the documents which the users has ownership of
        _ = db.collection("notes").whereField("Uid", arrayContains: user?.uid as Any).getDocuments() { (querySnapshot, err) in
            if err != nil{
                print("Error getting documents")
            } else {
                for document in querySnapshot!.documents {
                    if let title = document.data()["title"] as? String {
                        //add all titles to array
                        self.notes.append(title)
                    }
                    if document == document {
                        //add all DocIDs to the array
                        self.documentIDs.append(document.documentID)
                    }
                    
                    
                }
                //set the datasource and reload
                self.tblNotes.delegate = self
                self.tblNotes.dataSource = self
                self.tblNotes.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //here for slide to delete function
        self.tblNotes.allowsSelectionDuringEditing = false
        
        //initial query
        getNotesFromDB()
        // Do any additional setup after loading the view.
    }
}
