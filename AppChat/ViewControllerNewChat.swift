//
//  ViewControllerNewChat.swift
//  AppChat
//
//  Created by Miguel Rangel on 4/25/19.
//  Copyright © 2019 Miguel Rangel. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerNewChat: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellUser", for: indexPath) as! TableViewCellUsers
        
        cell.txtUsername.text = dataUsers[indexPath.row]
        cell.txtInicial.text = String(dataUsers[indexPath.row].prefix(1)) as String
        cell.sKey = dataUsers[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create chat
        ref = Database.database().reference()

        ref?.child("Chats/CH"+String(Int.random(in: 1245...148761))).setValue(["Message": "New chat",                                                            MyVariables.user: 1,
                                                            self.dataUsers[indexPath.row]: 1])
        // Dismiss
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var dataUsers = [String]()
    
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        handle = ref?.child("Users").observe(.childAdded, with: { (snapshot) in
                if(snapshot.key != MyVariables.user) {
                    self.dataUsers.append(snapshot.key)
                    self.tableView.reloadData()
                }
        })
    }
    

    @IBAction func buBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
