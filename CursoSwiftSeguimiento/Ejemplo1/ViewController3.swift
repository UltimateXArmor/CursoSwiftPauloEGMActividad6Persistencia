//
//  ViewController3.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import Foundation
import UIKit

class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
