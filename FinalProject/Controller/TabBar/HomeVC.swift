//  HomeVC.swift
//  FinalProject
//
//  Created by loujain on 01/01/2022.
//

import UIKit
class HomeVC: UIViewController {

    var titles = [
    Titles ( name: "احجز جلستك مع الاخصائي المناسب لك"),
    Titles ( name: "استشارة فورية"),
    Titles ( name: "سهلناها عليك و جمعنا لك افضل عيادات تغذية")
    ]
    var drArray : [Doctor] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeVC:  UITableViewDelegate , UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell
        cell.label.text = titles[indexPath.row].name
        return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index == 0 {
            
//            let selectedObject = titles[indexPath.row]
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "doctor") as! DoctorsVC
//            nextVC?.idd = drArray[indexPath.row].id
            present(nextVC, animated: true, completion: .none)
        
        } else if index == 1 {
            
//            let selectedObject = titles[indexPath.row]
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "drVC") as! DrVC
            present(nextVC, animated: true, completion: .none)
            
        }else{
//            let selectedObject = titles[indexPath.row]
            let next = storyboard?.instantiateViewController(withIdentifier: "nextVC") as? NutritionClinics
            present(next!, animated: true, completion: .none)
            
        }
}
}
