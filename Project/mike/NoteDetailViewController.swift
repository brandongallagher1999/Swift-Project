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
        print("share")
        var uid = String()
        let shareAlert = UIAlertController(title: "Share note", message: "Enter the email of the user you'd like to share the note with.", preferredStyle: UIAlertController.Style.alert)
        shareAlert.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let shareAction = UIAlertAction(title: "Share", style: .default)  { (action) in
            let textField = shareAlert.textFields![0]
            self.db.collection("users").whereField("email", isEqualTo: textField.text).getDocuments() { (querySnapshot, err) in
                if let err = err{
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
        print("about to share")
        present(shareAlert, animated: true, completion: nil)
    }
    @IBAction func editNote(_ sender: Any) {
        print("edit")
    }
    
    func addUidToNote(uid : String){
        var uids = [String]()
        print("UID IS \(uid)")
        db.collection("notes").document(noteId).getDocument(source: .cache) { (document, error) in
            if let document = document {
                let oldUids = document.get("Uid") as! [String]
                for old in oldUids{
                    uids.append(old)
                }
                print(uids)
                uids.append(uid)
                self.db.collection("notes").document(self.noteId).updateData(["Uid" : uids])
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(noteId)
        
        let docRef = db.collection("notes").document(noteId)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let noteTitle = document.data()!["title"] as? String
                let noteContent = document.data()!["content"] as? String
                print(noteTitle as Any)
                print(noteContent as Any)
                self.title = noteTitle
                self.NavBar.topItem!.title = noteTitle
                self.tvContent.text = noteContent
//https://stackoverflow.com/questions/27652227/how-can-i-add-placeholder-text-inside-of-a-uitextview-in-swift
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
