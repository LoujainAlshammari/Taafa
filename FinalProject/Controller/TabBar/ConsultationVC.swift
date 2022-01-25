//
//  ConsultationVC.swift
//  FinalProject
//
//  Created by loujain on 03/01/2022.
//

import UIKit
import Firebase
class ConsultationVC: UIViewController  {
    
    
    let   durations = ["30 دقيقة",
                       "45 دقيقة",
                       "60 دقيقة"]
    
    var duration = ""
    let tranView = UIView()
    let tableView = UITableView()
    var button1 = UIButton()
    var dataSource = [String]()
    let datePiicker = UIDatePicker()
    let timePiicker = UIDatePicker()
    let db = Firestore.firestore()
    var namee = ""
    
    @IBOutlet weak var durationButton: UIButton!
    @IBOutlet weak var pickerDuration: UIPickerView!
    @IBOutlet var dateTex: UITextField!
    @IBOutlet weak var timeTex: UITextField!
    @IBOutlet weak var viewConsultation: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConsultation.cornerRadius = 30
        pickerDuration.isHidden = true
        pickerDuration.delegate = self
        pickerDuration.dataSource = self
        pickerDuration.tag = 1
        createDatePicker()
        createTimePicker()
    }
    
    @IBAction func durationButtonAct(_ sender: Any) {
        if pickerDuration.isHidden{
            pickerDuration.isHidden = false
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "doctor")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    func createDatePicker(){
        
        dateTex.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressd))
        let flexSpce = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: #selector(donePressd))
        
        toolbar.setItems([flexSpce,doneBtn], animated: true)
        datePiicker.frame.size = CGSize(width: 0, height: 250)
        dateTex.inputAccessoryView = toolbar
        dateTex.inputView = datePiicker
        datePiicker.datePickerMode = .date
        datePiicker.preferredDatePickerStyle = .inline
        datePiicker.backgroundColor = #colorLiteral(red: 0.7008361816, green: 0.8273791671, blue: 0.842361629, alpha: 1)
        
    }
    
    @objc func donePressd(){
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateStyle = .none
        dateTex.text = "\(datePiicker.date)"
        self.view.endEditing(true)
        
    }
    
    func createTimePicker(){
        
        timeTex.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneePressd))
        let flexSpcee = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: #selector(donePressd))
        
        toolbar.setItems([flexSpcee,doneBtn], animated: true)
        timePiicker.frame.size = CGSize(width: 0, height: 250)
        timeTex.inputAccessoryView = toolbar
        timeTex.inputView = timePiicker
        timePiicker.datePickerMode = .time
        timePiicker.preferredDatePickerStyle = .wheels
        timePiicker.backgroundColor = #colorLiteral(red: 0.7008361816, green: 0.8273791671, blue: 0.842361629, alpha: 1)
        
        
    }
    
    @objc func doneePressd(){
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateStyle = .none
        timeTex.text = "\(timePiicker.date)"
        self.view.endEditing(true)
        
    }
    
    @IBAction func confirmationButton(_ sender: Any) {
        
        uploadDataToFireBaseAppt()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Appt")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    func uploadDataToFireBaseAppt(){
        
        if Auth.auth().currentUser?.uid != nil {
            
            db.collection("Appointment").document(Auth.auth().currentUser!.uid).setData(
                ["id":Auth.auth().currentUser!.uid,
                 "duration" : self.duration,
                 "time": self.timeTex.text!,
                 "date" :self.dateTex.text!
                ])
        }
    }
  
}

extension ConsultationVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return durations.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return durations[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        durationButton.setTitle(durations[row], for: .normal)
        pickerDuration.isHidden = true
        print(durations[row])
        self.duration = durations[row]
    }
}


