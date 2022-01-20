//
//  ProfileVC.swift
//  FinalProject
//
//  Created by loujain on 05/01/2022.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {

    var name : String = ""
    var email: String = ""
    var gender : String = ""
    var heigt : String = ""
    var weight : String = ""


    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var genderProfile: UILabel!
    @IBOutlet weak var heigtProfile: UILabel!
    @IBOutlet weak var weightProfile: UILabel!
    
    var genderPt = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        getDataFromFireBasePt()
        self.genderProfile.text = genderPt
    }

    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButton(_ sender: Any) {
        let second = self.storyboard?.instantiateViewController(withIdentifier: "toEdit")
                  second!.modalPresentationStyle = .fullScreen
                  self.present(second!, animated: true, completion: nil)

    }
    
    
    func getDataFromFireBasePt(){
        print(Auth.auth().currentUser!.uid)
        db.collection("Patient").whereField("id", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { QuerySnapshot, error in
            if let error = error{
                print(error)
            }
            else{
            for doc in QuerySnapshot!.documents{
                let data = doc.data()
                
                let namePt = data["ptName"] as? String ?? ""
                let emailPt = data["ptEmail"] as? String ?? ""
                let gender = data["gender"] as? String ?? ""
                let heigtPt = data["height"] as? String ?? ""
                let weightPt = data["weight"] as? String ?? ""
                let id = data["id"] as? String? ?? ""
                
                
                print("####",namePt)
                print("####",emailPt)
                print("####",gender)
                print("####",heigtPt)
                print("####",weightPt)
                
                self.nameProfile.text = namePt
                self.emailProfile.text = emailPt
                self.genderProfile.text = gender
                self.weightProfile.text = weightPt
                self.heigtProfile.text = heigtPt
                



            }
            }
       
        }
    }
}
