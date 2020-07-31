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
    
   
    @IBOutlet weak var tvContent: UITextView!
    var noteId = String()
    var noteTitle = String()
    var noteContent = String()
    let db = Firestore.firestore()
    @IBOutlet weak var NavBar: UINavigationBar!
    
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
