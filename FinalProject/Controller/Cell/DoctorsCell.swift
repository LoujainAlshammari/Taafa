//
//  DoctorsCell.swift
//  FinalProject
//
//  Created by loujain on 03/01/2022.
//

import UIKit

class DoctorsCell: UITableViewCell {

    @IBOutlet weak var imageProfiile: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var descriptionDoctor: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var viewDr: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewDr.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

   
}
