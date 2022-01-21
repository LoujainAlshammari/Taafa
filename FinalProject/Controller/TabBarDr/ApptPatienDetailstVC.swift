//
//  ApptPatienDetailstVC.swift
//  FinalProject
//
//  Created by loujain on 19/01/2022.
//

import UIKit

class ApptPatienDetailstVC: UIViewController {
    
    var apptPtObj : Appointment?
    var PtObj : Patient?
    
    @IBOutlet weak var namePt: UILabel!
    @IBOutlet weak var heightPt: UILabel!
    @IBOutlet weak var weightPt: UILabel!
    @IBOutlet weak var sessionDuration: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var viewInfoPatient: UIView!
    @IBOutlet weak var viewInfoSession: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionDuration.text = apptPtObj?.duration
        sessionTime.text = apptPtObj?.time
        sessionDate.text = apptPtObj?.date
        namePt.text = PtObj?.ptName
        heightPt.text = PtObj?.height
        weightPt.text = PtObj?.weight
        viewInfoPatient.layer.cornerRadius = 30
        viewInfoSession.layer.cornerRadius = 30
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePageDr")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)
    }

}
