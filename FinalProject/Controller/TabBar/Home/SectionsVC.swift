//
//  SectionsVC.swift
//  FinalProject
//
//  Created by loujain on 02/01/2022.
//

import UIKit

class SectionsVC: UIViewController {
    var clinicObj: Clinics?
    
    
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var nutritionistsName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var number: UILabel!

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.layer.cornerRadius = 20
        secondView.layer.cornerRadius = 20

        clinicName.text = clinicObj?.clinicName
        nutritionistsName.text = clinicObj?.nutritionistsName
        location.text = clinicObj?.location

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func phoneNum(_ sender: Any) {
        
        if let phoneURL = NSURL(string: ("tel://" + "0538645400")) {
            UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)}
    }
}
