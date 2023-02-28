//
//  ViewController.swift
//  AlertPractice
//
//  Created by Ecem Öztürk on 1.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var password2Text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupClicked(_ sender: Any) {
        
        if usernameText.text == "" {
           makeAlert(titleInput: "ERROR", msgInput: "Please enter your username!")
        } else if passwordText.text == "" {
            makeAlert(titleInput: "ERROR", msgInput: "Please enter your password!")
        } else if passwordText.text != password2Text.text {
            makeAlert(titleInput: "ERROR", msgInput: "Passwords do not match!")
        } else {
            makeAlert(titleInput: "SUCCESS", msgInput: "User OK")
        }
    }
    
    func makeAlert (titleInput: String, msgInput: String) {
        let alert = UIAlertController(title: titleInput, message: msgInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)/*{ UIAlertAction in
            print("button clicked")
            }
            */
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

