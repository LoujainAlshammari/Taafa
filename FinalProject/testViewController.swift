//
//  testViewController.swift
//  FinalProject
//
//  Created by loujain on 03/01/2022.
//

import UIKit

class cellClass : UITableViewCell{
    
}
class testViewController: UIViewController {

    @IBOutlet weak var selectButton: UIButton!
    
    let tranView = UIView()
    let tableView = UITableView()
    var button1 = UIButton()
    var dataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClass.self, forCellReuseIdentifier: "cell")
    }
    func addTran(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        tranView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(tranView)
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tranView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        tranView.addGestureRecognizer(tapgesture)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut , animations: {
            self.tranView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
        
    }
    
        @objc func removeTransparentView(){
            let frames = button1.frame
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut , animations: {
                self.tranView.alpha = 0
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            }, completion: nil)
        }
    
    @IBAction func onClickSelect(_ sender: Any) {
        dataSource = ["a","b","c"]
        button1 = selectButton
        addTran(frames: selectButton.frame)
    }
    
  
}

extension testViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}





