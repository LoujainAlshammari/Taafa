//
//  doctorProfileVC.swift
//  FinalProject
//
//  Created by loujain on 09/01/2022.
//

import UIKit
import Firebase
class DoctorProfileVC: UIViewController {
    let db = Firestore.firestore()
//    var doctorInfo : Doctor? = nil
    var drInfo : [Doctor] = []

    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameDr: UILabel!
    @IBOutlet weak var emailDr: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var certificationDr: UILabel!
    @IBOutlet weak var experienceDr: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var ibanDr: UILabel!
    
    let imagePicker = UIImagePickerController()
    var updateimageName = "\(UUID().uuidString).png"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getDataFromFireBase()
        
        firstView.layer.cornerRadius = 30
        secondView.layer.cornerRadius = 30
        thirdView.layer.cornerRadius = 30
        imgProfile.layer.cornerRadius = 15
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        alert()
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
    
    let userId = Auth.auth().currentUser?.uid

    
    func getDataFromFireBase(){
        print(Auth.auth().currentUser!.uid)
        db.collection("Nutritionist").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).addSnapshotListener { QuerySnapshot, error in
            //                       if let error = error {
            //                           print(error.localizedDescription)
            //                QuerySnapshot?.documents.forEach({ QueryDocumentSnapshot in
            //
            //                    let nameDoctor : String = ((QueryDocumentSnapshot.get("drName")as? String)!)
            //
            //                    let emailDoctor : String = ((QueryDocumentSnapshot.get("email")as? String)!)
            //
            //                    let  imgStr  : Data = ((QueryDocumentSnapshot.get("icon")as? Data) ?? Data())
            //
            //                    let gender : String = ((QueryDocumentSnapshot.get("gender")as? String)!)
            //
            //                    let certificationDr : String = ((QueryDocumentSnapshot.get("certification")as? String)!)
            //
            //                    let expDoctor : String = ((QueryDocumentSnapshot.get("experience")as? String)!)
            //
            //                    let desDoctor : String = ((QueryDocumentSnapshot.get("description")as? String)!)
            //
            //                    let costDoctor : String = ((QueryDocumentSnapshot.get("cost")as? String)!)
            //
            //                    let bankNameDr: String = ((QueryDocumentSnapshot.get("bankName")as? String)!)
            //
            //                    let iban: String = ((QueryDocumentSnapshot.get("iban")as? String)!)
            //
            //
            //                    self.nameDr.text = nameDoctor
            //                    self.emailDr.text = emailDoctor
            //                    self.gender.text = gender
            //                    self.certificationDr.text = certificationDr
            //                    self.experienceDr.text = expDoctor
            //                    self.textArea.text = desDoctor
            //                    self.cost.text = costDoctor
            //                    self.bankName.text = bankNameDr
            //                    self.ibanDr.text = iban
            //                    self.imgProfile.image = UIImage(data: imgStr)
            //                    //                               self.imgProfile.image = imgStr
            //                    //                               self.getImage(imgStr: imgStr)
            //
            //                    //                               self.drInfo.append(Doctor(id: "", drName: nameDoctor, email: emailDoctor, icon:imgStr, certification: certificationDr,
            //                    //                                                          experience: certificationDr, description: desDoctor, cost: costDoctor, bankName: bankNameDr))
            //                })
            
            if let error = error{
                print(error)
            }
            else{
                for doc in QuerySnapshot!.documents{
                    let data = doc.data()
                    let nameDoctor = data["drName"] as? String ?? ""
                    let emailDoctor = data["email"] as? String ?? ""
                    let gender  = data ["gender"] as? String ?? ""
                    let certificationDr = data ["certification"] as? String ?? ""
                    let expDoctor = data ["experience"] as? String ?? ""
                    let desDoctor = data ["description"] as? String ?? ""
                    let costDoctor = data ["cost"] as? String ?? ""
                    let bankNameDr = data ["bankName"] as? String ?? ""
                    let iban = data ["iban"] as? String ?? ""
                    let imgStr = data ["icon"] as? Data ?? Data()
                    
                    
                    self.nameDr.text = nameDoctor
                    self.emailDr.text = emailDoctor
                    self.gender.text = gender
                    self.certificationDr.text = certificationDr
                    self.experienceDr.text = expDoctor
                    self.textArea.text = desDoctor
                    self.cost.text = costDoctor
                    self.bankName.text = bankNameDr
                    self.ibanDr.text = iban
                    self.imgProfile.image = UIImage(data: imgStr)
                    
                    
                    
                }
            }
            
        }
        
    }
    
    
    //    if let snapshotDocuments = querySnapshot?.documents {
    //                            for doc in snapshotDocuments {
    //                                let data = doc.data()
    //                                let phone = data["phoneNumnber"] as? String ?? ""
    //                                let firstName = data["firstName"] as! String
    //                                let isVerified = data["isVerified"] as? Bool ?? false
    //                                self.username.text = firstName
    //                                self.email.text = Auth.auth().currentUser!.email
    //                                let profilePic = data["image"] as! Data
    //                                if isVerified{
    //                                    self.verfied.image = UIImage(systemName: "star.circle.fill") ?? UIImage()
    //                                }
    
    
    
    //    func getData() {
    //
    //
    //        if let userId = userId {
    //            db.collection("Nutritionist").document(userId).getDocument{ documentSnapshot, error in
    //                if let error = error {
    //                    print("Error: ",error.localizedDescription)
    //                } else{
    ////                    for doc in snapshotDocuments {
    ////                        let data = doc.data()
    //                    self.nameDr.text = documentSnapshot?.get("drName") as? String ?? "nil"
    ////                    self.emailDr.text = data("email") as? String ?? "nil"
    ////                    self.gender.text = documentSnapshot?.get("gender") as? String ?? "nil"
    ////                    self.certificationDr.text = data("certification") as? String ?? "nil"
    ////                    self.experienceDr.text = data("experience") as? String ?? "nil"
    ////                    self.textArea.text = data("description") as? String ?? "nil"
    ////                    self.cost.text = data("cost") as? String ?? "nil"
    ////                    self.bankName.text = data("bankName") as? String ?? "nil"
    //
    //                    let imgStr = documentSnapshot?.get("icon") as? String ?? "nil"
    ////                        if isVerified{
    //                            self.imgProfile.image = UIImage(systemName: "star.circle.fill") ?? UIImage()
    ////                        }
    //
    ////                    self.getImage(imgStr: imgStr)
    ////                }
    //            }
    //        }
    //    }
    //    }
    
    
    func uploadImage(){
        let imagefolder = Storage.storage().reference().child("images")
        if let imageData = imgProfile.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(updateimageName).putData(imageData, metadata: nil){
                (metaData , error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    print("update image Succ..")
                }
            }
        }
    }
    
    
    func getImage(imgStr: String) {
        let url = "gs://finalproject-2cf68.appspot.com/images/" + "\(imgStr)"
        let Ref = Storage.storage().reference(forURL: url)
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                self.imgProfile.image = UIImage(data: data!)
            }
        }
    }
    
    func updateUserIcon() {
        uploadImage()
        self.db.collection("Nutritionist")
            .document(userId!).updateData(
                [
                    "icon": imgProfile.image == UIImage(systemName: "person.circle") ? "nil" : updateimageName
                ])
        {(error) in
            if error == nil {
                print("Added image Succ..")
            }else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    
}

extension DoctorProfileVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      imgProfile.image = pickedImage
    updateUserIcon()
    picker.dismiss(animated: true, completion: nil)
  }
}



