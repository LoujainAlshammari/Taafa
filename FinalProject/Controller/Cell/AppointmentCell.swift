//
//  AppointmentCell.swift
//  FinalProject
//
//  Created by loujain on 17/01/2022.
//

import UIKit

class AppointmentCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sessionDuration: UILabel!
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var viewAppt: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewAppt.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
