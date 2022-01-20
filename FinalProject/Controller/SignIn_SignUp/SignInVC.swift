//
//  ViewController.swift
//  FinalProject
//
//  Created by loujain on 23/12/2021.
//

import UIKit
import Firebase
class SignInVC: UIViewController {
    
    @IBOutlet weak var viewSignIn: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var buttonSignIn: UIButton!
    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewSignIn.layer.cornerRadius = 30
        emailTextField.layer.cornerRadius = 60
        passwordTextField.layer.cornerRadius = 25
        buttonSignIn.layer.cornerRadius = 10
        
        emailTextField.text = "abdullah@gmail.com"
        passwordTextField.text = "1234567"
        
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toReset", sender: nil)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        login()

    }
    

    @IBAction func signUpButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toCreate", sender: nil)
        
    }
    
    func login(){
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: { user, error in
                
                if error == nil {
                     
                    if (Auth.auth().currentUser?.email?.contains("@taafa")) == true {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePageDr")
                        vc!.modalPresentationStyle = .fullScreen
                        self.present(vc!, animated: true, completion: nil)
                        
                    }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePage")
                    vc!.modalPresentationStyle = .fullScreen
                        print("idddddddd",Auth.auth().currentUser!.uid)
                    self.present(vc!, animated: true, completion: nil)
                     
                    self.emailTextField.text = nil
                    self.passwordTextField.text = nil
                   
                    }
                }else {
                    let alert = UIAlertController(title: "تنبيه", message: "كلمة المرور غير صالحة أو ليس لدى المستخدم كلمة مرور", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                })
        }else {
            let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
     }
   }


