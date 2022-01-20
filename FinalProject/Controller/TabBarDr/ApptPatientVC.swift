//
//  ApptPatientVC.swift
//  FinalProject
//
//  Created by loujain on 19/01/2022.
//

import UIKit
import Firebase
class ApptPatientVC: UIViewController {
    
    var apptPatientArray : [Appointment] = []
    
    var Ptobj : [Patient] = []
    let db = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFireBase()
        self.tableView.reloadData()
    }
    

    func getDataFromFireBase(){
        
        print(Auth.auth().currentUser!.uid)
        
        db.collection("Appointment").getDocuments { querySnapshot, err  in
            if let err = err {
                print("error get document : \(err)")
            } else {
                var id = ""
                for document in querySnapshot!.documents{
                    print("=====")
                    let data = document.data()
                     id = data["id"] as? String ?? ""
                    print("?????///",id)
                    print(document.data())
                    self.apptPatientArray.append(Appointment(id: "", duration: data["duration"] as? String ?? "",
                                                             time:data["time"] as? String ?? "",
                                                             date: data["date"] as? String ?? ""))
                    self.tableView.reloadData()
                    self.db.collection("Patient").whereField("id", isEqualTo: id).getDocuments { querySnapshot, error in
                        if let error = error{
                            print(error)
                        }else{
                            for doc in querySnapshot!.documents{
                                let data = doc.data()
                                let namePt = data["ptName"] as? String ?? ""
                                let heigtPt = data["height"] as? String ?? ""
                                let weightPt = data["weight"] as? String ?? ""
                                
                                self.Ptobj.append(Patient(id: "", ptName: namePt, ptEmail: "", gender: "", height: heigtPt, weight: weightPt))
                            }
                        }
                    }
                }
          
                
            }
        }
    }

}

extension ApptPatientVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apptPatientArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApptPatientCell
        cell.namePt.text = apptPatientArray[indexPath.row].duration
        
        
                return cell

      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = apptPatientArray[indexPath.row]
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "ApptPatienDetailstVC") as! ApptPatienDetailstVC
        print(selectedObject.id)
        nextVC.apptPtObj = selectedObject
        nextVC.PtObj = Ptobj[indexPath.row]
        present(nextVC, animated: true){
        }
    }

   
}
