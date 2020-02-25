//
//  TempratureViewController.swift
//  UnitConversion
//
//  Created by Isuru Wijesinghe on 2/20/20.
//  Copyright © 2020 Devon Wijesinghe. All rights reserved.
//

import UIKit

enum TemperatureUints: Int{
    case celsius, farenheit, kelvin
}

class TempratureViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tf_celcius: UITextField!
    @IBOutlet weak var tf_faren: UITextField!
    @IBOutlet weak var tf_kelvin: UITextField!
    @IBOutlet weak var keyboard: KeyboardController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.assignDelegates()
        // Do any additional setup after loading the view.
    }
    
    let temprature = Temperature.init(celsius: 0.0, farenheit: 0.0, kelvin: 0.0, historyStringArray: [])
    
    func assignDelegates(){
        tf_celcius.delegate = self
        tf_faren.delegate = self
        tf_kelvin.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("WORKING !!")
        
         keyboard.activeTextField = textField
    }
    
    @IBAction func onTfValueChanged(_ sender: UITextField) {
        
        guard let textFieldValue = sender.text else { return }
        guard let doubleTextFieldValue = Double(textFieldValue) else { return }
        
        switch TemperatureUints(rawValue: sender.tag) {
        case .celsius:
            temprature.celsius = doubleTextFieldValue
            temprature.farenheit = (doubleTextFieldValue * 9/5 + 32)
            temprature.kelvin = doubleTextFieldValue + 273.15
            
            tf_faren.text = "\(temprature.farenheit)"
            tf_kelvin.text = "\(temprature.kelvin)"
        case .farenheit:
            let faren = doubleTextFieldValue
            let celsius = (doubleTextFieldValue - 32) * 5/9
            let kel = doubleTextFieldValue + 273.15
            
            tf_celcius.text = "\(celsius)"
            tf_kelvin.text = "\(kel)"
        case .kelvin:
            let kel = doubleTextFieldValue
            let celsius = (doubleTextFieldValue - 32) * 5/9
            let faren = (doubleTextFieldValue - 273.15) * 9/5 + 32
            
            tf_celcius.text = "\(celsius)"
            tf_faren.text = "\(faren)"
        default:
            print("kel")
        }
    }
    
    @IBAction func onSavePressed(_ sender: UIBarButtonItem) {
        
        let defaults = UserDefaults.standard
        let historyString =  "\(temprature.celsius) = celsius --> \(temprature.farenheit) = farenheit --> \(temprature.kelvin) = kelvin "
        print(historyString)
        
        temprature.historyStringArray.append(historyString)
        defaults.set(temprature.historyStringArray, forKey: "TemperatureHistory")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
