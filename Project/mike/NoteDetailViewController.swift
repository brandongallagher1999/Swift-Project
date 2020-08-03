//
//  NoteDetailViewController.swift
//  Project
//
//  Created by Michael Brownlow on 2020-07-29.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class NoteDetailViewController: UIViewController {
    
   
    @IBOutlet weak var btnShare: UIBarButtonItem!
    @IBOutlet weak var btnUpdate: UIBarButtonItem!
    @IBOutlet weak var tvContent: UITextView!
    
    
    var noteId = String()
    var noteTitle = String()
    var noteContent = String()
    let db = Firestore.firestore()
    
    @IBOutlet weak var NavBar: UINavigationBar!
    
    
    
    @IBAction func ShareNote(_ sender: Any) {
        //make alert for sharing based off email
        let shareAlert = UIAlertController(title: "Share note", message: "Enter the email of the user you'd like to share the note with.", preferredStyle: UIAlertController.Style.alert)
        shareAlert.addTextField()
        
        //cancel and share buttons
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let shareAction = UIAlertAction(title: "Share", style: .default)  { (action) in
            
            let textField = shareAlert.textFields![0]
            
            //query to find the user's uid then add it to the note based of the document ID
            self.db.collection("users").whereField("email", isEqualTo: textField.text!).getDocuments() { (querySnapshot, err) in
                if err != nil{
                    print("error")
                } else{
                    for document in querySnapshot!.documents {
                        self.addUidToNote(uid : document.data()["uid"] as! String)
                    }
                }
            }
        }
        
        shareAlert.addAction(cancelAction)
        shareAlert.addAction(shareAction)
        
        present(shareAlert, animated: true, completion: nil)
    }
    @IBAction func editNote(_ sender: Any) {
        let editAlert = UIAlertController(title: "Edit Note", message: "Edit your title and content.", preferredStyle: .alert)
        
        editAlert.addTextField()
        editAlert.addTextField()
        let titleText = editAlert.textFields![0]
        let contentText = editAlert.textFields![1]
        
        //insert the old text into the textfields of the alert
        titleText.insertText(self.NavBar.topItem!.title!)
        contentText.insertText(self.tvContent.text)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            //update the note based of the docID with the new content
            self.db.collection("notes").document(self.noteId).updateData(["title" : titleText.text!, "content" : contentText.text!])
            
            //set the title and content to the updated text
            self.tvContent.text = contentText.text
            self.NavBar.topItem!.title = titleText.text
        }
        
        editAlert.addAction(cancelAction)
        editAlert.addAction(confirmAction)
        
        present(editAlert, animated: true, completion: nil)
    }
    
    func addUidToNote(uid : String){
        var uids = [String]()
        
        //retrieve the array of uids and then add the new uid to the list.
        db.collection("notes").document(noteId).getDocument(source: .cache) { (document, error) in
            if let document = document {
                let oldUids = document.get("Uid") as! [String]
                for old in oldUids{
                    uids.append(old)
                }
                uids.append(uid)
                //update with the new array
                self.db.collection("notes").document(self.noteId).updateData(["Uid" : uids])
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docRef = db.collection("notes").document(noteId)
        
        //get the document based off the id of the selected note and populate the views
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let noteTitle = document.data()!["title"] as? String
                let noteContent = document.data()!["content"] as? String
                self.title = noteTitle
                self.NavBar.topItem!.title = noteTitle
                self.tvContent.text = noteContent
            }
        }
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
