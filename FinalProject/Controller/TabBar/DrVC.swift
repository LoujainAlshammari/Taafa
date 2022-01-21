//
//  drVC.swift
//  FinalProject
//
//  Created by loujain on 18/01/2022.
//

import UIKit
import Firebase

class DrVC: UIViewController {
    
    var drsArray : [SelectDrs] = []
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFireBase()
        self.tableView.reloadData()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePage")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    func getDataFromFireBase(){
        
        db.collection("Nutritionist")
            .getDocuments { QuerySnapshot, error in
                
                for document in QuerySnapshot!.documents{
                    let data = document.data()
                    print(document.data())
                    let nameDoctor = data ["drName"] as? String ?? " notFound "
                    print("############",nameDoctor)
                    let id = data ["id"] as? String ?? " notFound "
                    self.drsArray.append(SelectDrs(idDr: id, nameDr: nameDoctor))
                    self.tableView.reloadData()
                    
                }
            }
    }
    
    
}


extension DrVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drsCell", for: indexPath) as! DrCell
        cell.nameDr.text = drsArray[indexPath.row].nameDr
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = drsArray[indexPath.row]
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "chatting") as! ChattingVC
        print(selectedObject.nameDr)
        nextVC.drsObj = selectedObject
        nextVC.id = drsArray[indexPath.row].idDr
        present(nextVC, animated: true){
        }
    }
}
