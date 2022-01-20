//
//  OnboardingCVCell.swift
//  FinalProject
//
//  Created by loujain on 15/01/2022.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCVCell.self)
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var slideTitleLbl: UILabel!
    
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    
    func setUp (_ slide: OnboardingSlide){
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
