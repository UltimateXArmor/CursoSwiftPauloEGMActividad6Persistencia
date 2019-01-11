//
//  RegisterViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UIDatePicker!
    @IBOutlet weak var empnumberTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func registerAction(_ sender: Any) {
        if let tname = nameTextField.text, tname.count > 0, let temail = emailTextField.text, temail.count > 0, let empNumber = empnumberTextField.text, empNumber.count > 0, let phone = phoneTextField.text, phone.count > 0, let password = passwordTextField.text, password.count > 0, let confirm = confirmpasswordTextField.text, confirm.count > 0 {
            
            if (password != confirm){
                let alert = UIAlertController(title: "Advertencia", message: "Las contraseñas no coinciden.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let date = birthdayTextField.date
            let newUser = User()
            newUser.name = tname
            newUser.email = temail
            newUser.pass = password
            newUser.birthday = date
            newUser.phone = phone
            newUser.empNumber = empNumber
            Configurations.users.append(newUser)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            //let user = User(context: context)
            //user.name = "Roger"
            //appDelegate.saveContext()
            let nuser = UserObject(context: context)
            nuser.name = tname
            nuser.email = temail
            nuser.pass = password
            nuser.birthday = date
            nuser.phone = phone
            nuser.empNumber = empNumber
            appDelegate.saveContext()
            
            let alert = UIAlertController(title: "Advertencia", message: "Registro exitoso.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Advertencia", message: "Complete los campos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
