//
//  ApptPatientCell.swift
//  FinalProject
//
//  Created by loujain on 19/01/2022.
//

import UIKit

class ApptPatientCell: UITableViewCell {

    @IBOutlet weak var imagePt: UIImageView!
    @IBOutlet weak var namePt: UILabel!
    
    @IBOutlet weak var viewAppt: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewAppt.layer.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
