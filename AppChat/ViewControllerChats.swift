//
//  ViewControllerChats.swift
//  AppChat
//
//  Created by Miguel Rangel on 4/25/19.
//  Copyright © 2019 Miguel Rangel. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerChats: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatUsernameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellChat", for: indexPath) as! TableViewCellChats
        
        cell.txtUsername.text = chatUsernameData[indexPath.row]
        cell.txtInicial.text = String(chatUsernameData[indexPath.row].prefix(1)) as String
        cell.txtMessaage.text = chatMessageData[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatSegue" {
            if let viewController = segue.destination as? ViewControllerMessage {
                viewController.sReceiver = itemSelected
                viewController.sChatKey = sChatKey ?? ""
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Set selected
        itemSelected = chatUsernameData[indexPath.row]
        sChatKey = chatData[indexPath.row]
        // perfom segue
        performSegue(withIdentifier: "ChatSegue", sender: nil)
    }
    

    var chatUsernameData = [String]()
    var chatMessageData  = [String]()
    var chatData = [String]()
    var itemSelected:String!
    var sChatKey:String!
    
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var handleMsg:DatabaseHandle?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        handle = ref?.child("Chats").observe(.childAdded, with: {(snapshot) in

            if snapshot.hasChild(MyVariables.user) {
                
                let enumerator = snapshot.children
                
                while let rest = enumerator.nextObject() as? DataSnapshot {
                    
                    if rest.key == "Message" {
                        
                        self.chatMessageData.append(rest.value as! String)
                        
                    } else {
                    
                        if rest.key != MyVariables.user {
                            
                            self.chatUsernameData.append(rest.key)
                            self.chatData.append(snapshot.key)
                            
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                    
                }
                
            }
        
        })
    
    }
    
    
    @IBAction func buLogOut(_ sender: Any) {
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
