//
//  NutritionClinics.swift
//  FinalProject
//
//  Created by loujain on 01/01/2022.
//

import UIKit

class NutritionClinics: UIViewController {


    var clinics = [
        Clinics (clinicName: "مستشفئ الحبيب", nutritionistsName: "امل كنانة - غدير السوسي ", location: "طريق الملك فهد - العليا - الرياض"),
        
        Clinics (clinicName: "مستشفئ التخصصي", nutritionistsName: "رزان الفهد - ميادة العنزي", location: "طريق الملك عبدالله - الملك فيصل - الرياض"),
//        Clinics (clinicName: <#T##String#>, nutritionistsName: <#T##String#>, location: <#T##String#>, number: <#T##Int#>),
//        Clinics (clinicName: <#T##String#>, nutritionistsName: <#T##String#>, location: <#T##String#>, number: <#T##Int#>)

    ]
//    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}

extension NutritionClinics:  UITableViewDelegate , UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clinics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! NutritionClinicsCell
        cell.label.text = clinics[indexPath.row].clinicName
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObject = clinics[indexPath.row]
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! SectionsVC
        print(selectedObject.clinicName)
        nextVC.clinicObj = selectedObject
        present(nextVC, animated: true){
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

}
