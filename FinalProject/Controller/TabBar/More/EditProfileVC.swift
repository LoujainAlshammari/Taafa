//
//  EditProfileVC.swift
//  FinalProject
//
//  Created by loujain on 17/01/2022.
//

import UIKit
import Firebase

class EditProfileVC: UIViewController {
    
    let db = Firestore.firestore()
    var selectedGender = ""
    var selectedHeigt = ""
    var selectedWeight = ""
    var ptArray = [Patient]()
    
    let gender = ["ذكر" , "انثى"]
    let weight = ["50 - 55", "55 - 60" , "60 - 65" , "65 - 70" , "70 - 75" , "75 - 80" , "80 - 85" , "85 - 90"  , "90 - 95" , "95 - 100"]
    let height = ["140", "145" , "150" , "155" , "160" , "165" , "170" , "175"  , "180" , "185"]
    
    @IBOutlet weak var pickerGender: UIPickerView!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var pickerWeight: UIPickerView!
    @IBOutlet weak var selectWeightButton: UIButton!
    @IBOutlet weak var selectHeightButton: UIButton!
    @IBOutlet weak var pickerHeight: UIPickerView!
    @IBOutlet weak var viewEdit: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewEdit.layer.cornerRadius = 30
        
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
        updateDataToFireBasePt()
        let alert = UIAlertController(title: "حفظ" , message: "تم حفظ البيانات بنجاح", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func updateDataToFireBasePt(){
        
        let newData = [
            "id":Auth.auth().currentUser!.uid,
            "height" : self.selectedHeigt,
            "weight" : self.selectedWeight,
            "gender" : self.selectedGender]
        
        
        db.collection("Patient").whereField("id", isEqualTo: Auth.auth().currentUser!.uid as Any).getDocuments { [self] (result, error) in
            if error == nil{
                for document in result!.documents{
                    //document.setValue(“1", forKey: “isolationDate”)
                    db.collection("Patient").document(document.documentID).setData(newData , merge: true)
                }
            }
        }
    }
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

