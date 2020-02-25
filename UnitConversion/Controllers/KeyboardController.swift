//
//  KeyboardController.swift
//  UnitConversion
//
//  Created by Isuru Wijesinghe on 2/13/20.
//  Copyright © 2020 Devon Wijesinghe. All rights reserved.
//

import UIKit

enum KeyboardButton: Int {
    case zero, one, two, three, four, five, six, seven, eight, nine, perriod, delete, negation
}

class KeyboardController: UIView {

    @IBOutlet weak var containerView: UIView!
   
     let nibName = "KeyBoard"
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
     }
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
     }
     
     func commonInit() {
         guard let view = loadViewFromNib() else { return }
         view.frame = self.bounds
         self.addSubview(view)
     }
     
     func loadViewFromNib() -> UIView? {
         let nib = UINib(nibName: nibName, bundle: nil)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
    
    var activeTextField = UITextField()

    @IBAction func onButtonPressed(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        if let currentText = self.activeTextField.text{
            switch KeyboardButton(rawValue: sender.tag) {
            case .perriod:
                if !currentText.contains("."), currentText.count != 0 {
                    activeTextField.insertText(".")
                    setCurserPosition(from: cursorPosition)
                }
            case .delete:
                if currentText.count != 0 {
                    self.activeTextField.text?.remove(at: currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1))
                    setCurserPosition(from: cursorPosition, offset: -1)
                }
            case .negation:
                if !currentText.contains("-"), currentText.count != 0 {
                    activeTextField.text?.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 0))
                    setCurserPosition(from: cursorPosition)
                }
            default:
                activeTextField.insertText(String(sender.tag))
                setCurserPosition(from: cursorPosition)
            }
        }
        
    }
    
    func getCursorPosition() -> Int {
        guard let selectedRange = activeTextField.selectedTextRange else { return 0}
        return activeTextField.offset(from: activeTextField.beginningOfDocument, to: selectedRange.start)
    }
    
    func setCurserPosition(from: Int, offset: Int = 1) {
        if let newPosition = activeTextField.position(from: activeTextField.beginningOfDocument, offset: from + offset){
            activeTextField.selectedTextRange = activeTextField.textRange(from: newPosition, to: newPosition)
        }
    }
    
}
