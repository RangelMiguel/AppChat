//
//  ViewControllerMessage.swift
//  AppChat
//
//  Created by Miguel Rangel on 4/25/19.
//  Copyright © 2019 Miguel Rangel. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerMessage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var isEdit:Bool = false
    @IBOutlet weak var txtNewMessage: UITextView!
    
    func handlerEdit(alert: UIAlertAction!) {
        isEdit = true;
        txtNewMessage.text = dataMessages[selectedItem]["Message"] as! String
    }
    
    func handlerDelete(alert: UIAlertAction!) {
        ref?.child("Messages/" + (dataMessages[selectedItem]["Id"] as! String)).removeValue()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        // Show alert
        let alert = UIAlertController(title: "Choose?", message: "Choose an action", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: handlerEdit(alert:)))
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: handlerDelete(alert:)))
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellMessage") as! TableViewCellMessage
        
        cell.txtSender.text = dataMessages[indexPath.row]["Sender"] as! String
        cell.txtMessage.text = dataMessages[indexPath.row]["Message"] as! String
        cell.txtDate.text = dataMessages[indexPath.row]["Date"] as! String
        
        // Style
        if dataMessages[indexPath.row]["Sender"] as! String == MyVariables.user {
            cell.txtSender.textAlignment = .right
            cell.txtMessage.backgroundColor = .blue
            cell.txtMessage.textAlignment = .right
        }
        
        return cell
    }

    @IBAction func buSend(_ sender: Any) {
        if isEdit {
            // UPDATE
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let dateInFormat = dateFormatter.string(from: NSDate() as Date)
            
            ref = Database.database().reference()
            ref?.child("Messages/" + (dataMessages[selectedItem]["Id"] as! String)).setValue(["ChatKey": self.sChatKey,
                                                                                       "Date": dateInFormat,
                                                                                       "Message": txtNewMessage.text!,
                                                                                       "Sender": MyVariables.user])
            // Clean
            txtNewMessage.text = ""
            isEdit = false
        } else {
            // INSERT
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let dateInFormat = dateFormatter.string(from: NSDate() as Date)
            
            ref = Database.database().reference()
            ref?.child("Messages/MSG"+String(Int.random(in: 1245...148761))).setValue(["ChatKey": self.sChatKey,
                                                                                       "Date": dateInFormat,
                                                                                       "Message": txtNewMessage.text!,
                                                                                       "Sender": MyVariables.user])
            // Clean
            txtNewMessage.text = ""
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barNavigation: UINavigationItem!
    var sReceiver:String!
    var sChatKey:String!
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var dataMessages = [[String: Any?]]()
    var selectedItem:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        barNavigation.title = "ChatKlon - " + sReceiver
        
        // Listener of ne messages
        ref = Database.database().reference()
        
        handle = ref?.child("Messages").observe(.childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let chatkey = value?["ChatKey"] as? String ?? ""
            
            if chatkey == self.sChatKey {
                // Add to the dictionary
                var dictionary : [String: Any?] = ["Sender": value?["Sender"] as? String ?? "",
                                                   "Message": value?["Message"] as? String ?? "",
                                                   "Date": value?["Date"] as? String ?? "",
                                                   "Id": snapshot.key as? String ?? ""
                ]
                self.dataMessages.append(dictionary)
                
                self.tableView.reloadData()
                
            }
            
        })
        
        // Do any additional setup after loading the view.
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
