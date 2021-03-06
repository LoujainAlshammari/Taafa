//
//  HomePageVC.swift
//  FinalProject
//
//  Created by loujain on 06/01/2022.
//

import UIKit
import Firebase

class HomePageDrVC: UIViewController {
    
    let db = Firestore.firestore()
    var PtArr  : [Patient] = []
    var usersArray : [Message] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFireBasePt()
        self.tableView.reloadData()
        
    }
    
    
    func getDataFromFireBasePt(){
        print(Auth.auth().currentUser!.uid)
        db.collection("Patient").addSnapshotListener{ QuerySnapshot, error in
            if let error = error{
                print(error)
            }else{
                for doc in QuerySnapshot!.documents{
                    let data = doc.data()
                    let namePt = data["ptName"] as? String ?? ""
                    let idPt = data["id"] as? String? ?? ""
                    let heightPt = data["height"] as? String? ?? ""
                    let weightPt = data["weight"] as? String? ?? ""
                    
                    self.PtArr.append(Patient(id: idPt ?? "" , ptName: namePt,
                                              ptEmail: "", gender: "", height: heightPt, weight: weightPt))
                }
                self.tableView.reloadData()
            }
        }
    }
}


extension HomePageDrVC:  UITableViewDelegate , UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PtArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPation") as! HomePageDrCell
        cell.name.text = PtArr[indexPath.row].ptName
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "chatting") as! ChattingVC
        nextVC.id = PtArr[indexPath.row].id
        present(nextVC, animated: true, completion: .none)
        
    }
}
