//
//  chattingVC.swift
//  FinalProject
//  Created by loujain on 04/01/2022.
//

import UIKit
import Firebase
class ChattingVC: UIViewController {

    var messages : [Message] = []
    var drsObj: SelectDrs?
    var id : String = ""
    var myName  = ""
    let db = Firestore.firestore()
    let myId = Auth.auth().currentUser?.uid
    
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getMessage()
    }
    
 
       @IBAction func sendButtonClicked(_ sender: Any) {
           sendMessage()
       }
    
    func sendMessage(){
        
        let msg = ["content": messageTextField.text!, "id": myId!,
                   "Name" : myName, "time" : FieldValue.serverTimestamp()] as [String:Any]
        
        print("*******\(myName)")
        let myId = Auth.auth().currentUser?.uid
        
        self.db.collection("Patient").document(myId!)
            .collection("Message").document(self.id).collection("msg").document().setData(msg as [String : Any])
        
        
        self.db.collection("Patient").document(self.id)
            .collection("Message").document(myId!).collection("msg").document().setData(msg as [String : Any])
        
        getMessage()
    }
     
    
    func getMessage(){
           
        
        
        
        db.collection("Patient").document(myId!)
            .collection("Message").document(self.id).collection("msg")
            .order(by: "time")
            .addSnapshotListener { (querySnapshot, error) in
                self.messages = []
                if let e = error {
                    print(e)
                }else {
                    if let snapshotDocuments = querySnapshot?.documents{
                        for document in snapshotDocuments {
                            let data = document.data()
                            if let id = data["id"] as? String,
                               let content = data["content"] as? String
                                
                            {
                                let fetchedMessage = Message(idM: id, message: content)
                                self.messages.append(fetchedMessage)
                                print("############",self.messages)
                                //   DispatchQueue.main.async {
                                self.tableView.reloadData()
                                //   }
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    
    @IBAction func backButton(_ sender: Any) {
        
        if (Auth.auth().currentUser?.email?.contains("@taafa")) == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "homePageDr")
            vc!.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
            
        }else{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "drVC")
        vc!.modalPresentationStyle = .fullScreen
            print("idddddddd",Auth.auth().currentUser!.uid)
        self.present(vc!, animated: true, completion: nil)
      
        }
        
        
        
    }
    
}


extension ChattingVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "chatCell",for: indexPath) as! ChatCell
        cell.message.text! = self.messages[indexPath.row].message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
