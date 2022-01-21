//
//  HomePageDrCell.swift
//  FinalProject
//
//  Created by loujain on 10/01/2022.
//

import UIKit

class HomePageDrCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var viewCellPt: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCellPt.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
