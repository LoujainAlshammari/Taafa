//
//  MorePageVC.swift
//  FinalProject
//
//  Created by loujain on 05/01/2022.
//

import UIKit
import Firebase

class MorePageVC: UIViewController {
    var defaults = UserDefaults.standard

    @IBOutlet weak var darkLight: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        
        alert()
    }
    
    @IBAction func profileButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func darkLightMode(_ sender: Any) {
        
        if defaults .bool(forKey: "mode") == false {
                   
                   if darkLight.isOn == true {
                       
                       UIApplication.shared.windows.forEach { window in
                           window.overrideUserInterfaceStyle = .dark }
                   }else {
                       
                       if #available(iOS 10.0, *) {
                           
                           UIApplication.shared.windows.forEach { window in
                               window.overrideUserInterfaceStyle = .light }
                       }
                   }
               }else{
                   
               }
    }
    
    
    func alert(){

        let alert = UIAlertController(title: "تسجيل الخروج", message: "هل انت متاكد ؟", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "لا", style: .cancel , handler: .none))
        
        alert.addAction(UIAlertAction(title: "نعم", style: .default , handler: { UIAlertAction in
            
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true, completion: nil)
        }))
                          
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
