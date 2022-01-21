//
//  drsTVC.swift
//  FinalProject
//
//  Created by loujain on 18/01/2022.
//

import UIKit

class DrCell: UITableViewCell {

    @IBOutlet weak var nameDr: UILabel!
    @IBOutlet weak var viewDrs: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewDrs.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
