//
//  ChatCell.swift
//  FinalProject
//
//  Created by loujain on 12/01/2022.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var message: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
