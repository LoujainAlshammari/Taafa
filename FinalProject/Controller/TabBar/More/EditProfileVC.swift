//
//  EditProfileVC.swift
//  FinalProject
//
//  Created by loujain on 17/01/2022.
//

import UIKit
import Firebase

class EditProfileVC: UIViewController {

    let gender = ["ذكر" , "انثى"]
    let weight = ["50 - 55", "55 - 60" , "60 - 65" , "65 - 70" , "70 - 75" , "75 - 80" , "80 - 85" , "85 - 90"  , "90 - 95" , "95 - 100"]
    let height = ["140", "145" , "150" , "155" , "160" , "165" , "170" , "175"  , "180" , "185"]
    
    var selectedGender = ""
    var selectedHeigt = ""
    var selectedWeight = ""
    var ptArray = [Patient]()

    let db = Firestore.firestore()

    
    @IBOutlet weak var pickerGender: UIPickerView!
    @IBOutlet weak var genderButton: UIButton!
    
    @IBOutlet weak var pickerWeight: UIPickerView!
    @IBOutlet weak var selectWeightButton: UIButton!
    
    @IBOutlet weak var selectHeightButton: UIButton!
    @IBOutlet weak var pickerHeight: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        getDataFromFireBasePt()
        
        pickerWeight.isHidden = true
        pickerHeight.isHidden = true
        pickerGender.isHidden = true

        pickerWeight.delegate = self
        pickerWeight.dataSource = self

        pickerHeight.delegate = self
        pickerHeight.dataSource = self
        
        pickerGender.delegate = self
        pickerGender.dataSource = self

        pickerWeight.tag = 1
        pickerHeight.tag = 2
        pickerGender.tag = 3
        

    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func genderButtonAct(_ sender: Any) {
        if pickerGender.isHidden{
            pickerGender.isHidden = false
        }
    }
    
    @IBAction func selectWeightAct(_ sender: Any) {
        if pickerWeight.isHidden{
            pickerWeight.isHidden = false
        }
    }
    
    @IBAction func selectHeightAct(_ sender: Any) {
        if pickerHeight.isHidden{
            pickerHeight.isHidden = false
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        uploadDataToFireBasePt()
        let alert = UIAlertController(title: "حفظ" , message: "تم حفظ البيانات بنجاح", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func uploadDataToFireBasePt(){

        let newData = [
            "id":Auth.auth().currentUser!.uid,
            "height" : self.selectedHeigt,
            "weight" : self.selectedWeight,
            "gender" : self.selectedGender]
        
            // db.collection("Patient").document().whereField("id", isEqualTo: Auth.auth().currentUser!.uid)
        
        
      //  let newData = ["imag" : dataImqge]
        db.collection("Patient").whereField("id", isEqualTo: Auth.auth().currentUser!.uid as Any).getDocuments { [self] (result, error) in
                            if error == nil{
                                for document in result!.documents{
                                    //document.setValue(“1", forKey: “isolationDate”)
                                    db.collection("Patient").document(document.documentID).setData(newData , merge: true)
                                }
                            }
                        }
        
        
        
//        db.collection("Patient").document(Auth.auth().currentUser!.uid).updateData([
//
//            "id":Auth.auth().currentUser!.uid,
//            "height" : self.selectedHeigt,
//            "weight" : self.selectedWeight,
//            "gender" : self.selectedGender
//
//        ]){error in
//            if error == nil {
//                print("Successful")
//                let pt = Patient(id: "", ptName: "", ptEmail: "", gender: self.selectedGender,
//                                 height: self.selectedHeigt, weight: self.selectedWeight)
//                self.ptArray.append(pt)
//
//            }else {
//                print("Eror")
//            }
//        }
//
    }
    
//    func getDataFromFireBasePt(){
//        print(Auth.auth().currentUser!.uid)
//        db.collection("Patient").whereField("ptEmail", isEqualTo: Auth.auth().currentUser!.email!).addSnapshotListener { QuerySnapshot, error in
//            if let error = error{
//                print(error)
//            }
//            else{
//                for doc in QuerySnapshot!.documents{
//                let data = doc.data()
////                let namePt = data["ptName"] as? String ?? ""
////                let emailPt = data["ptEmail"] as? String ?? ""
//                let id = data["id"] as? String? ?? ""
//
////                self.nameProfile.text = namePt
////                self.emailProfile.text = emailPt
//
////                let newData = ["name" : namePt, "email" : emailPt,"gender": self.selectedGender, "weight" : self.selectedWeight, "heigt" : self.selectedHeigt]
////                self.db.collection("Patient").document(Auth.auth().currentUser!.uid).setData(newData , merge: true)
//
//                let newData = ["gender": self.selectedGender, "weight" : self.selectedWeight, "heigt" : self.selectedHeigt]
//                self.db.collection("Patient").document(Auth.auth().currentUser!.uid).setData(newData , merge: true)
//
//
//            }
//            }
//
//        }
//    }

}


extension EditProfileVC : UIPickerViewDelegate,UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 1 {
        return weight.count
      } else if  pickerView.tag == 2{
        return height.count
      }else{
          return gender.count
      }
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView.tag == 1{
          return weight[row]
        }else if pickerView.tag == 2{
          return height[row]
        }else{
            return gender[row]
        }
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if (pickerView.tag == 1) {
      selectWeightButton.setTitle(weight[row], for: .normal)
                    pickerWeight.isHidden = true
        selectedWeight = self.weight[row]
    } else if pickerView.tag == 2{
      selectHeightButton.setTitle(height[row], for: .normal)
                    pickerHeight.isHidden = true
        selectedHeigt = self.height[row]
    }else{
        genderButton.setTitle(gender[row], for: .normal)
                      pickerGender.isHidden = true
        selectedGender = self.gender[row]
      }
  }
}

