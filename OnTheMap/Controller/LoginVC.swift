//
//  LoginVC.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
import UIKit
class LoginVC:UIViewController{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    private let autoHideKeyboardDelegate = Keyboard()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        email.delegate = autoHideKeyboardDelegate
        password.delegate = autoHideKeyboardDelegate
    }
    
    
    @IBAction func LOGIN(_ sender: Any) {
        loggingIn(true)
        AppClient.login(email: email.text!, password: password.text!) { success, error in
            if success {
                self.fetchStudentLocations()
            } else {
                self.loggingIn(false)
                self.showErrorAlert(message: error?.localizedDescription ?? "Login Failed")
            }
        }
    }
    
    @IBAction func SignUp(_ sender: Any) {
        openUrl(url: AppClient.Endpoints.signUp.url)

    }
    private func loggingIn(_ isLogginIn: Bool) {
        if isLogginIn {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
        
        //disable interactable views when login in progress
        email.isEnabled = !isLogginIn
        password.isEnabled = !isLogginIn
        loginButton.isEnabled = !isLogginIn
        signUpButton.isEnabled = !isLogginIn
    }
    
    private func fetchStudentLocations() {
        AppClient.getStudentLocations { (success, error) in
            self.loggingIn(false)
            if success {
                self.performSegue(withIdentifier: "showLocations", sender: nil)
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Login Failed")
            }
        }
    }
}
