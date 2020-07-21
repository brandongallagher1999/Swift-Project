//
//  NoteListViewController.swift
//  Project
//
//  Created by Michael Brownlow on 2020-07-19.
//  Copyright © 2020 Brandon Gallagher. All rights reserved.
//

import UIKit

class NoteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblNoteList: UITableView!
    
    let tempArray = ["this", "shit", "is", "temporary"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNoteList.delegate = self
        tblNoteList.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Got here")
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = tempArray[indexPath.row]
        return cell
    }

}
