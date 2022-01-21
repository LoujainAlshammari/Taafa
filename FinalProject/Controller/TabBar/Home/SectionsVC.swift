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
    @IBOutlet weak var viewInfoClinic: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var viewClinic: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.layer.cornerRadius = 30
        viewInfoClinic.layer.cornerRadius = 20
        secondView.layer.cornerRadius = 30
        viewClinic.layer.cornerRadius = 20
        
        clinicName.text = clinicObj?.clinicName
        nutritionistsName.text = clinicObj?.nutritionistsName
        location.text = clinicObj?.location
        number.text = clinicObj?.phone
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
