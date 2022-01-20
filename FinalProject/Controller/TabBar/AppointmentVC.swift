//
//  AppointmentVC.swift
//  FinalProject
//
//  Created by loujain on 17/01/2022.
//

import UIKit
import Firebase
class AppointmentVC: UIViewController {
    var apptArray : [Appointment] = []

    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
//    @IBOutlet weak var durationSession: UILabel!
//    @IBOutlet weak var timeSession: UILabel!
//    @IBOutlet weak var dateSession: UILabel!
    
    
    @IBOutlet weak var taableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        taableView.delegate = self
        taableView.dataSource = self
        loudData()
    }

    
    func loudData(){
            if let userID = userID {
                db.collection("Patient").document(userID)
                    .getDocument {
                        qurSnapShot, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            
                            self.db.collection("Appointment").document(Auth.auth().currentUser!.uid).addSnapshotListener { documentSnapshot, error in
                                if let error = error{
                                    print(error)
                                }else{
                                    let durationSession = documentSnapshot?.get("duration") as? String ?? ""
                                    let timeSession = documentSnapshot?.get("time") as? String ?? ""
                                    let dateSession  = documentSnapshot?.get("date")  as? String ?? ""
                                    
                                    self.apptArray.append(Appointment(id: "", duration: durationSession, time: timeSession, date: dateSession))
                                    self.taableView.reloadData()
                                }
                            }
                            
                            
                            
//                                .getDocuments { [self] (qurySnapshot, error) in
//                                    if let error = error {
//                                        print(error)
//                                    }else{
//
//                                        for doc in qurySnapshot!.documents {
//                                            let data = doc.data()
//                                            let durationSession = data["duration"] as? String ?? ""
//                                            let timeSession = data["time"] as? String ?? ""
//                                            let dateSession  = data ["date"] as? String ?? ""
//                                            if (doc.get("id")as? String ?? "nil") == (qurSnapShot?.get("id") as? String ?? "nil"){
//                                                self.apptArray.append(Appointment(id: "", duration: durationSession, time: timeSession, date: dateSession))
//
//                                                print("loginnnnnnnnnn",self.apptArray)
//                                            }
//                                            self.taableView.reloadData()
//                                        }
//                                    }
//                                }
                        }
                    }
            }
        }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "moveConsultationVC")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    
}




extension AppointmentVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apptArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        cell.sessionDuration.text = apptArray[indexPath.row].duration
        cell.sessionDate.text = apptArray[indexPath.row].date
        cell.sessionTime.text = apptArray[indexPath.row].time
        
                return cell
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                    let userid = Auth.auth().currentUser!.uid

                    if (editingStyle == .delete) {
                        print("\(userid)-\(apptArray[indexPath.row].id)")
                        db.collection("Appointment").document("\(userid)-\(apptArray[indexPath.row].id)").delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                let alert = UIAlertController(title: "", message: "تم حذف الموعد ", preferredStyle: .alert)
                                let action = UIAlertAction(title: "موافق", style: .default ,handler: { action in

                                    self.apptArray.remove(at: indexPath.row)
                                    self.taableView.reloadData()
                                })
                                alert.addAction(action)
                                self.present(alert, animated: true)
                                print("Document successfully removed!")
                            }
                        }
                    }

        }

}
