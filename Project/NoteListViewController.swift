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
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = tempArray[indexPath.row]
        return cell
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
