//
//  ViewController.swift
//  AppChat
//
//  Created by Miguel Rangel on 4/24/19.
//  Copyright © 2019 Miguel Rangel. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get database reference
        ref = Database.database().reference()
    }


    @IBAction func buLogin(_ sender: Any) {
        
        ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild(self.txtUsername.text!){
                
                var password = snapshot.childSnapshot(forPath: self.txtUsername.text!).childSnapshot(forPath: "Password").value
                
                if password as! String == self.txtPassword.text! {
                    
                    MyVariables.user = self.txtUsername.text!
                    
                    self.performSegue(withIdentifier: "login", sender: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Bad login", message: "Incorrect password", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                }
            }else{
                
                let alert = UIAlertController(title: "Bad login", message: "Username not found", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
            }
        })
    }
    
}

