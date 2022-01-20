//
//  HomePageDrCell.swift
//  FinalProject
//
//  Created by loujain on 10/01/2022.
//

import UIKit

class HomePageDrCell: UITableViewCell {


    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var viewCellPt: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCellPt.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
