//
//  TableViewCellChats.swift
//  AppChat
//
//  Created by Miguel Rangel on 4/26/19.
//  Copyright © 2019 Miguel Rangel. All rights reserved.
//

import UIKit

class TableViewCellChats: UITableViewCell {
    
    
    @IBOutlet weak var txtInicial: UILabel!
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtMessaage: UITextView!
    var sKey:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
