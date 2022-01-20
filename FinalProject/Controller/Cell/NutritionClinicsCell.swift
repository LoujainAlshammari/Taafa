//
//  NutritionClinicsCell.swift
//  FinalProject
//
//  Created by loujain on 01/01/2022.
//

import UIKit

class NutritionClinicsCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var viewNut: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewNut.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
