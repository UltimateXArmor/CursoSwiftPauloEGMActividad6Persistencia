//
//  EditEmployeeViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/10/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class EditEmployeeViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayDate: UIDatePicker!
    @IBOutlet weak var empNumberTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var user : UserObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadFields()
    }
    
    func loadFields(){
        guard let u = self.user else {return}
        self.nameTextField.text = "\(u.name ?? "")"
        self.emailTextField.text = "\(u.email ?? "")"
        self.birthdayDate.date = u.birthday ?? Date()
        self.empNumberTextField.text = "\(u.empNumber ?? "")"
        self.phoneTextField.text = "\(u.phone ?? "")"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveContext(_ sender: Any) {
        guard let u = self.user else {return}
        
        if let data = self.nameTextField.text, !data.isEmpty {
            u.name = data
        }
        
        if let data = self.emailTextField.text, !data.isEmpty {
            u.email = data
        }
        
        let date = self.birthdayDate.date
        u.birthday = date
        
        if let data = self.empNumberTextField.text, !data.isEmpty {
            u.empNumber = data
        }
        
        if let data = self.phoneTextField.text, !data.isEmpty {
            u.phone = data
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
}
