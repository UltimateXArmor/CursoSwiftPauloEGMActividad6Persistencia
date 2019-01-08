//
//  ViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("La vista cargó")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("La vista apareció")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("La vista va a aparecer")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("La vista desapareció")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("La vista va a desaparecer")
    }
}

