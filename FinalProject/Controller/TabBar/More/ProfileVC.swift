//
//  ProfileVC.swift
//  FinalProject
//
//  Created by loujain on 05/01/2022.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {

//    let gender = ["ذكر" , "انثى"]
//    let weight = ["50 - 55", "55 - 60" , "60 - 65" , "65 - 70" , "70 - 75" , "75 - 80" , "80 - 85" , "85 - 90"  , "90 - 95" , "95 - 100"]
//    let height = ["140", "145" , "150" , "155" , "160" , "165" , "170" , "175"  , "180" , "185"]

    var name : String = ""
    var email: String = ""
    var gender : String = ""
    var heigt : String = ""
    var weight : String = ""
    
//    var selectedGender = ""
//    var selectedHeigt = ""
//    var selectedWeight = ""

    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var genderProfile: UILabel!
    @IBOutlet weak var heigtProfile: UILabel!
    @IBOutlet weak var weightProfile: UILabel!
    
    var genderPt = ""
    //    @IBOutlet weak var pickerGender: UIPickerView!
//    @IBOutlet weak var selectImage: UIImageView!
//    @IBOutlet weak var pickerWeight: UIPickerView!
//    @IBOutlet weak var selectWeightButton: UIButton!
//    @IBOutlet weak var selectHeightButton: UIButton!
//    @IBOutlet weak var genderButton: UIButton!
//    @IBOutlet weak var pickerHeight: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        getDataFromFireBasePt()
//        getDataFromFireBasePt()
//
//        pickerWeight.isHidden = true
//        pickerHeight.isHidden = true
//        pickerGender.isHidden = true
//
//        pickerWeight.delegate = self
//        pickerWeight.dataSource = self
//
//        pickerHeight.delegate = self
//        pickerHeight.dataSource = self
//
//        pickerGender.delegate = self
//        pickerGender.dataSource = self
//
//        pickerWeight.tag = 1
//        pickerHeight.tag = 2
//        pickerGender.tag = 3
       // getDataFromFireBasePt()
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataFromFireBasePt()
        self.genderProfile.text = genderPt
    }
    
//    @IBAction func selectWeightAct(_ sender: Any) {
//        if pickerWeight.isHidden{
//            pickerWeight.isHidden = false
//        }
//    }
//
//    @IBAction func selectHeightAct(_ sender: Any) {
//        if pickerHeight.isHidden{
//            pickerHeight.isHidden = false
//        }
//    }
//
//    @IBAction func genderButtonAct(_ sender: Any) {
//        if pickerGender.isHidden{
//            pickerGender.isHidden = false
//        }
//    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButton(_ sender: Any) {
        let second = self.storyboard?.instantiateViewController(withIdentifier: "toEdit")
                  second!.modalPresentationStyle = .fullScreen
                  self.present(second!, animated: true, completion: nil)
//        self.performSegue(withIdentifier: "toEdit", sender: nil)

//        getDataFromFireBasePt()
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
                
            //    self.genderProfile.text = gender
              //  print("00000-0000000" , namePt , emailPt ,self.genderPt , heigtPt , weightPt)
                
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
                
//                DispatchQueue.main.async {
//                    self.nameProfile.text = namePt
//                    self.emailProfile.text = emailPt
//    //                self.genderProfile.text = genderPt
//                    self.weightProfile.text = weightPt
//                    self.heigtProfile.text = heigtPt
//                }
                

//
//                let newData = ["name" : namePt, "email" : emailPt,"gender": self.selectedGender, "weight" : self.selectedWeight, "heigt" : self.selectedHeigt]
//                self.db.collection("Patient").document(Auth.auth().currentUser!.uid).setData(newData , merge: true)


            }
            }
        //-------------------------
//        db.collection("Patient").getDocuments { [self] QuerySnapshot, error in
//            if error == nil {
//                QuerySnapshot?.documents.forEach({ QueryDocumentSnapshot in
//                    
//                    let namePt : String = ((QueryDocumentSnapshot.get("ptName")as? String)!)
//                    let emailPt: String = ((QueryDocumentSnapshot.get("ptEmail")as? String)!)
//  
//                    self.nameProfile.text = namePt
//                    self.emailProfile.text = emailPt
//                    
//                    
//                    let newData = ["gender": self.selectedGender, "weight" : self.selectedWeight, "heigt" : self.selectedHeigt]
//                    self.db.collection("Patient").document(Auth.auth().currentUser!.uid).setData(newData , merge: true)
//                   
//                })
//                
//          
//                
//                
//                
//            }
        }
    }
}


//extension ProfileVC : UIPickerViewDelegate,UIPickerViewDataSource{
//  func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    return 1
//  }
//  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    if pickerView.tag == 1 {
//        return weight.count
//      } else if  pickerView.tag == 2{
//        return height.count
//      }else{
//          return gender.count
//      }
//  }
//  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    if pickerView.tag == 1{
//          return weight[row]
//        }else if pickerView.tag == 2{
//          return height[row]
//        }else{
//            return gender[row]
//        }
//  }
//  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    if (pickerView.tag == 1) {
//      selectWeightButton.setTitle(weight[row], for: .normal)
//                    pickerWeight.isHidden = true
//        self.selectedWeight = self.weight[row]
//    } else if pickerView.tag == 2{
//      selectHeightButton.setTitle(height[row], for: .normal)
//                    pickerHeight.isHidden = true
//        selectedHeigt = self.height[row]
//    }else{
//        genderButton.setTitle(gender[row], for: .normal)
//                      pickerGender.isHidden = true
//        selectedGender = gender[row]
//      }
//  }
//}

