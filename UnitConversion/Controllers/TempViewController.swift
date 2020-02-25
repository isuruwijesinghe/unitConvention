//
//  TempViewController.swift
//  UnitConversion
//
//  Created by Isuru Wijesinghe on 2/13/20.
//  Copyright © 2020 Devon Wijesinghe. All rights reserved.
//

import UIKit

class TempViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tf_celcius: UITextField!
    @IBOutlet weak var keyboard: KeyboardController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.assignDelegates()
        // Do any additional setup after loading the view.
    }
    
    func assignDelegates(){
        tf_celcius.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("WORKING !!")
        keyboard.activeTextField = textField
        
    }

}
