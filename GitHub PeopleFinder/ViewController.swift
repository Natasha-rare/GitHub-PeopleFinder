//
//  ViewController.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 27.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var name: String = ""
    @IBOutlet weak var pnameTF: UITextField!
    @IBOutlet weak var errorLb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (self.name.count > 0){
            guard let dvc = segue.destination as? ResultsShowController else {return}
            dvc.FindPerson(name: self.name)
        }
        else{
            errorLb.text = "The name field can't be empty"
        }
    }
    
    @IBAction func findClicked(_ sender: Any){
        self.errorLb.text = ""
        self.name = pnameTF.text!
        print(pnameTF.text!)
    }
    
}

