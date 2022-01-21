//
//  nutritionistProfileVC.swift
//  FinalProject
//
//  Created by loujain on 05/01/2022.
//

import UIKit
import Firebase
import FirebaseStorage
import Photos

class CreateAccountDr: UIViewController {
    
    let genders = ["ذكر" , "انثى"]
    var gender = ""
    var doctorrArray = [Doctor]()
    var imageProfile = UIImagePickerController()
    let db = Firestore.firestore()
    let imagePicker = UIImagePickerController()
    var imageName = "\(UUID().uuidString).png"
    var img = UIImage()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    //------------------
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var pickerGender: UIPickerView!
    //------------------
    @IBOutlet weak var certification: UITextField!
    @IBOutlet weak var experience: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var description1: UITextView!
    //------------------
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var iban: UITextField!
    //----
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var buttonCreate: UIButton!
    //------------------
    @IBOutlet weak var imageProfileDr: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imageProfileDr.layer.cornerRadius = imageProfileDr.frame.width/2
        pickerGender.isHidden = true
        pickerGender.delegate = self
        pickerGender.dataSource = self
        imageProfile.delegate = self
        pickerGender.tag = 1
        firstView.layer.cornerRadius = 30
        secondView.layer.cornerRadius = 30
        thirdView.layer.cornerRadius = 30
        buttonCreate.layer.cornerRadius = 10
        imageProfileDr.layer.cornerRadius = 15
        
        hideKeyboardWhenTappedAround()
        
    }
    
   
    
    @IBAction func backButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpPt")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func genderButtonAct(_ sender: Any) {
        
        if pickerGender.isHidden{
            pickerGender.isHidden = false
        }
    }
    
    @IBAction func createButton(_ sender: Any) {
      
        if check() {
            checkUserDr()
        }
    }
    
    func checkUserDr(){
        
        if email.text != "" && password.text != "" {
    Auth.auth().createUser(withEmail: email.text!, password: password.text!) { result, error in
                if let error = error {
                    
                    print("error while creating user")
                    print(error.localizedDescription)
                    
                }else {
                    
                    self.uploadDataToFireBase()
                    print("done")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePageDr")
                    vc!.modalPresentationStyle = .fullScreen
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            
        }else {
            
            let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البايانات كامله", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    func uploadDataToFireBase(){
        
        uploadImage()
        
        db.collection("Nutritionist").document(Auth.auth().currentUser!.uid).setData([
            
            "id":Auth.auth().currentUser!.uid,
            "drName" : self.name.text!,
            "email":self.email.text!,
            "icon":  uploadImage(img),
            "isNutritionist" : true ,
            "certification" : self.certification.text!,
            "experience" : self.experience.text! ,
            "cost" : self.cost.text!,
            "description":self.description1.text! ,
            "bankName":self.bankName.text! ,
            "iban" : self.iban.text!,
            "gender": self.gender
            
        ])
    }
    
    func uploadImage(_ image : UIImage) -> Data{
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {return Data()}
        return imageData
    }
    
    func uploadImage() {
        
        let imagefolder = Storage.storage().reference().child("images")
        if let imageData = imageProfileDr.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(imageName).putData(imageData, metadata: nil){ (metaData , err) in
                
                if let error = err {
                    
                    print(error.localizedDescription)
                    
                }else {
                    print("تم رفع الصورة بنجاح")
                }
            }
        }
        
    }
    
    func hideKeyboardWhenTappedAround() {
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
 
    func check() -> Bool {
            
            if name.text!.isEmpty {
                
                
                let alert = UIAlertController(title: "تنبيه", message: "لم تقم بأدخال الأسم ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
                
            }else if certification.text!.isEmpty {
                
                let alert = UIAlertController(title: "تنبيه", message: "لم تقم بأدخال المؤهل الدراسي ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }else if experience.text!.isEmpty {
                
                let alert = UIAlertController(title: "تنبيه", message:"لم تقم بأدخل سنوات الخبرة ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }else if cost.text!.isEmpty {
                
                let alert = UIAlertController(title: "تنبيه", message:"لم تقم بأدخل تكلفة الاستشارة  ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
                
            }else if cost.text! < "50" {
                let alert = UIAlertController(title: "تنبيه", message:"تكلفة الاستشارة اقل من 50 ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }else if cost.text! > "300"{
                
                let alert = UIAlertController(title: "تنبيه", message:"تكلفة الاستشارة اكبر من 300", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }else if description1.text!.isEmpty {
                
                let alert = UIAlertController(title: "تنبيه", message:"لم تقم بأدخل وصف ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }else if bankName.text!.isEmpty {
                
                let alert = UIAlertController(title: "تنبيه", message:"لم تقم بأدخل اسم البنك ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }else if iban.text!.isEmpty {
                
                let alert = UIAlertController(title: "تنبيه", message:"لم تقم بأدخل الايبان", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                return false
                
            }
        
            return true
        }
    
}



extension CreateAccountDr : UIPickerViewDelegate,UIPickerViewDataSource{
    
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
      
    return 1
  }
    
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
   
          return genders.count
  }
    
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            return genders[row]
  }
    
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

      genderButton.setTitle(genders[row], for: .normal)
      pickerGender.isHidden = true
      print(genders[row])
      self.gender = genders[row]
   }
}

extension CreateAccountDr : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.img = pickedImage!
        imageProfileDr.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
