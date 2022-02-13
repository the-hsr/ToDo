//
//  ViewController.swift
//  DemoPurpose
//
//  Created by Himanshu Singh on 02/02/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [String]()
    
    
    @IBOutlet weak var infoMsg: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        input.delegate=self
        input.becomeFirstResponder()
        if self.data.count==0 {
            self.infoMsg.text="Enter details"
            self.infoMsg.alpha=1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if self.data.count==0 {
                UIView.animate(withDuration: 0.25)    {
                    self.infoMsg.alpha=1
                    self.infoMsg.text="Add ToDo Item"
                }
                
            }
        }
    }

    @IBAction func addTo(_ sender: UIButton) {
        if (input.text==""){
            alertUser(msg: "Enter a ToDo item to add to the list...")
            return
        }
        addToDo()
    }
    func addToDo(){
        let textField = input.text
        if(textField != ""){
            let newIndex = IndexPath(row: data.count, section: 0)
            self.data.append(textField!)
            self.tableView.insertRows(at: [newIndex], with: .fade)
            if self.data.count != 0 {
                UIView.animate(withDuration: 0.25)    {
                    self.infoMsg.alpha=0
                }
                
            }
            self.input.text=""
            
        }else{
            print("empty")
        }
    }
    func alertUser(msg: String){
        let alert = UIAlertController(title: "Oops",
                                      message: msg,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == input{
            addToDo()
        }
    return true
    }
    
}
