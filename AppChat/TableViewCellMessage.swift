//
//  TableViewCellMessage.swift
//  AppChat
//
//  Created by Miguel Rangel on 4/26/19.
//  Copyright © 2019 Miguel Rangel. All rights reserved.
//

import UIKit

class TableViewCellMessage: UITableViewCell {

    @IBOutlet weak var txtSender: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var txtDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
