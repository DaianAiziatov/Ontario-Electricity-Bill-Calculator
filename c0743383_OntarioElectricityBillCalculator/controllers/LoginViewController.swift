//
//  ViewController.swift
//  c0743383_OntarioElectricityBillCalculator
//
//  Created by Daian Aiziatov on 09/11/2018.
//  Copyright © 2018 Daian Aiziatov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var user: User?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.backBarButtonItem?.color = #colorLiteral(red: 0.08085308811, green: 0.5322463749, blue: 0.5532977817, alpha: 1)
        //rounded borders button
        loginButtonOutlet.layer.cornerRadius = 5
        loginButtonOutlet.layer.borderWidth = 1
    }

    @IBAction func login(_ sender: UIButton) {
        if isUserValid() {
            let userDefault = UserDefaults.standard
            userDefault.set(emailTextField.text, forKey: "email")
            userDefault.set(passwordTextField.text, forKey: "password")
//            print(user?.accountNumber)
//            print(user?.meterNumber)
            userDefault.set(user?.accountNumber, forKey: "accountNumber")
            userDefault.set(user?.meterNumber, forKey: "meterNumber")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let entryVC = sb.instantiateViewController(withIdentifier: "entryVC")
            navigationController?.pushViewController(entryVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Wrong email/password", message: "Please try again", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func isUserValid() -> Bool {
        var isValid = false;
        for user in User.allUsers {
            if emailTextField.text == user.email && passwordTextField.text == user.password {
                isValid = true
                self.user = user
                break
            }
        }
        return isValid
    }
    
    
    
}

