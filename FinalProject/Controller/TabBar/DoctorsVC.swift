//
//  DoctorsVC.swift
//  FinalProject
//
//  Created by loujain on 03/01/2022.
//

import UIKit
import Firebase

class DoctorsVC: UIViewController {

    var drArray : [Doctor] = []
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataDrFromFireBase()
        self.tableView.reloadData()

    }
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePage")
                vc!.modalPresentationStyle = .fullScreen
               self.present(vc!, animated: true, completion: nil)
    }
    
    
    
    func getDataDrFromFireBase(){
        
        print(Auth.auth().currentUser!.uid)
        
        db.collection("Nutritionist").getDocuments { querySnapshot, err  in
            if let err = err {
                print("error get document : \(err)")
            } else {
                for document in querySnapshot!.documents{
                    print("=====")
                    let data = document.data()
                    print(document.data())
                    self.drArray.append(Doctor(id: "", drName: data["drName"] as? String ?? "",
                                               email: "", icon: data["icon"] as? Data ?? Data(),
                                               gender: "", certification: "", experience: data["experience"] as? String ?? "",
                                               description: data["description"] as? String ?? "",
                                               cost: data["cost"] as? String ?? "",
                                               bankName: ""))
                    self.tableView.reloadData()
                }
            }
        }
    }

    

}

extension DoctorsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorsCell
        cell.imageProfiile.image = UIImage(data: drArray[indexPath.row].icon)
        cell.doctorName.text = drArray[indexPath.row].drName
        cell.descriptionDoctor.text = drArray[indexPath.row].description
        cell.info.text =  drArray[indexPath.row].cost
        
                return cell

      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = drArray[indexPath.row]
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "detailsDrProfile") as! DetailsDrVC
        print(selectedObject.drName)
        nextVC.drObj = selectedObject
        present(nextVC, animated: true){
        }
    }

   
}
 

