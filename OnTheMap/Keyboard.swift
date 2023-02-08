//
//  Keyboard.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
import UIKit
class Keyboard:NSObject,UITextFieldDelegate{
    var activeTextField: UITextField? = nil
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard when user press enter
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
