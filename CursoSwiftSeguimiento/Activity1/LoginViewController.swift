//
//  LoginViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    @IBAction func loginAction(_ sender: Any) {
        //let success = Configurations.users.filter({$0.email == user && $0.pass == pass}).first
        var request = URLRequest(url: NSURL(string: "http:develogeeks.com/beFunkey/api/User/login.php?username=email&password=pass")! as URL)
        request.httpMethod = "POST"
        
        guard let user = userTextField.text, user.count > 0, let pass = passwordTextField.text, pass.count > 0  else {
            let alert = UIAlertController(title: "Advertencia", message: "Datos incorrectos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let logEmail = "email=\(user) && password=\(pass)"
        request.httpBody = logEmail.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if (error != nil){ print("error=\(String(describing: error))") } else {
                if let resp = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: resp) as! [String:AnyObject]
                        for item in jsonResult {
                            if item.key == "message" {
                                let alert = UIAlertController(title: "Advertencia", message: "\(item.value as! String ?? "")", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                                    NSLog("The \"OK\" alert occured.")
                                }))
                                
                                DispatchQueue.main.async {
                                    self.present(alert, animated: true, completion: nil)
                                }
                                
                            }
                        }
                        
                    } catch {}
                }
            }
        }
        
        task.resume()
    }
    //http:develogeeks.com/beFunkey/api/User/login.php?username=email&password=pass
}
