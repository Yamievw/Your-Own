//
//  LogInViewController.swift
//  YamievanWijnbergen-pset6
//
//  ViewController where for the user to log in or register (using Firebase)
//
//  Created by Yamie van Wijnbergen on 19/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keep user logged in when closing app.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "homeScreen", sender: nil)
            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Let a user log in with email address and matching password.
    @IBAction func loginDidTouch(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil {
                self.loginFail()
            
                if Auth.auth().currentUser != nil {
                    self.performSegue(withIdentifier: "homeScreen", sender: self)
                }
            }
        }
    }
    
    // Let a user register with a email adress and password.
    @IBAction func signupDidTouch(_ sender: Any) {
        let alertController = UIAlertController(title: "Register", message:
            "Choose a password that contains at least 6 characters.", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!,password: passwordField.text!) { user, error in
                if error == nil {
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!,password: self.passwordField.text!)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        // Add the text field in alertview.
        alertController.addTextField { textField in
            textField.text = ""
            textField.placeholder = "Enter email"
        }
            
        alertController.addTextField { textField in
            textField.text = ""
            textField.isSecureTextEntry = true
            textField.placeholder = " Password "
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // Alert to let user know login failed.
    func loginFail() {
    let alertcontroller = UIAlertController(title: "Failed to login.", message: "Please, try again.",preferredStyle: UIAlertControllerStyle.alert)
    
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        
        alertcontroller.addAction(OKAction)
        self.present(alertcontroller, animated: true, completion:nil)
        
        return
    }
}
