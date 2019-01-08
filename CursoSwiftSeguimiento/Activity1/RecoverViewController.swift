//
//  RecoverViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class RecoverViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordMessage: UILabel!
    
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
    @IBAction func recoverPasswordAction(_ sender: Any) {
        if let email = emailTextField.text, email.count > 0 {
            if let success = Configurations.users.filter({$0.email == email}).first {
                self.passwordMessage.text = "Listo, su contraseña es: \(success.pass)"
            } else {
                let alert = UIAlertController(title: "Advertencia", message: "Ese correo no esta registrado.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Advertencia", message: "Complete los campos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
