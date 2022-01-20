//
//  detailsDrVC.swift
//  FinalProject
//
//  Created by loujain on 13/01/2022.
//

import UIKit
import Firebase

class DetailsDrVC: UIViewController {
    var drObj: Doctor?
    let db = Firestore.firestore()

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionn: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var viewDetailsDr: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDetailsDr.cornerRadius = 30
        imageProfile.image = UIImage(data: drObj?.icon ?? Data())
        name.text = drObj?.drName
        descriptionn.text = drObj?.description
        experience.text = drObj?.experience
        cost.text = drObj?.cost

    }
    
  
    

    
  
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePage")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func clickToBooking(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "moveConsultationVC")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)

    }
    

    
    
  

}
