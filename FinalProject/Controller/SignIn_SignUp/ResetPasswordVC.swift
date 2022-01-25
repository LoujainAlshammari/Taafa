//
//  ResetPasswordVC.swift
//  FinalProject
//
//  Created by loujain on 01/01/2022.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var changePasswordText: UITextField!
    @IBOutlet weak var viewResetPass: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewResetPass.layer.cornerRadius = 20
        let user = Auth.auth().currentUser
        emailTextField.text = "\(user?.email ?? "email not found")"
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? "") { (error) in
            if error == nil {
                
                let alert = UIAlertController(title: "تم", message: "لقد تلقيت رسالة بالبريد إلكتروني ، تحقق من بريدك الإلكتروني!" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("حسناً", comment: "Default action"), style: .default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                
            }else {
                
                let alert = UIAlertController(title: "تنبية", message: error?.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("حسناً", comment: error!.localizedDescription), style: .default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)


    }
    
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
