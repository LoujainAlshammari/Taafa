//
//  CreateAccountVC.swift
//  FinalProject
//
//  Created by loujain on 01/01/2022.
//

import UIKit
import Firebase
class CreateAccountVC: UIViewController , UITextFieldDelegate {
    var pttArray  = [Patient]()
    let db = Firestore.firestore()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var buttonSignUp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSignUp.layer.cornerRadius = 30
        buttonSignUp.layer.cornerRadius = 10
    }

    
    @IBAction func createButton(_ sender: Any) {
        
        checkUserPt()
    //    uploadDataToFireBasePt()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePage")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)

    }
     
    @IBAction func moveToPageDr(_ sender: Any) {
//        let vc = nutritionistProfileVC()
//        present(vc, animated: true, completion: nil)
        
        let second = self.storyboard?.instantiateViewController(withIdentifier: "CreateDr")
                  second!.modalPresentationStyle = .fullScreen
                  self.present(second!, animated: true, completion: nil)
    }
    
    
    func checkUserPt(){
        
        if emailTextField.text != "" && passwordTextField.text != "" {
    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                result, error in
                if let error = error {
                    print("error while creating user")
                    print(error.localizedDescription)
                }else {
                    self.uploadDataToFireBasePt()
                    print("done")
                }
            }
        } else {
            let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func uploadDataToFireBasePt(){

//        db.collection("Patient").document(Auth.auth().currentUser!.uid).setData([
//
//            "id":Auth.auth().currentUser!.uid,
//              "ptName" : self.nameTextField.text!,
//              "ptEmail":self.emailTextField.text!,
//               "ptPassword" : self.passwordTextField.text!,
//                "isPatient" : true
//        ])
        
        db.collection("Patient").addDocument(data: [

            "id":Auth.auth().currentUser!.uid,
            "ptName" : self.nameTextField.text!,
            "ptEmail":self.emailTextField.text!,
            "ptPassword" : self.passwordTextField.text!,
            "isPatient" : true

        ]){error in
            if error == nil {
                print("Successful")
                let pt = Patient(id: Auth.auth().currentUser!.uid, ptName: self.nameTextField.text!, ptEmail: self.emailTextField.text!, gender: "", height: "", weight: "")
                self.pttArray.append(pt)

            }else {
                print("Eror")
            }
        }
    }
    
    
    
//    
//        func hideKeyboardWhenTappedAround(_ textField: UITextField) -> Bool {
//            nameTextField.resignFirstResponder()
//            return true
//        }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "moveToTimeLine"{
    //            let vc = ProfileVC()
    //            vc.name = nameTextField.text ?? "name no found "
    //            vc.email = emailTextField.text ?? "email no found "
    //        }
    //    }
}

