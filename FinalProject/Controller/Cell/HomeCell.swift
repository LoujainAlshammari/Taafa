//
//  HomeTableViewCell.swift
//  FinalProject
//
//  Created by loujain on 01/01/2022.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var viewHome: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewHome.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
