//
//  LogInViewController.swift
//  YamievanWijnbergen-pset6
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginDidTouch(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil {
                print("login successful")
            
                if Auth.auth().currentUser != nil {
                
                    self.performSegue(withIdentifier: "searchGIFViewController", sender: nil)
                }
            }
            else{
                // let user know he/she failed to login
                let alertcontroller = UIAlertController(title: "Failed to login.", message: "Please, try again.",preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                }
                alertcontroller.addAction(OKAction)
                self.present(alertcontroller, animated: true, completion:nil)
                return
            }
        }
    }
    
    
    @IBAction func signupDidTouch(_ sender: Any) {
        let alertController = UIAlertController(title: "New user", message:
            "Create new account", preferredStyle: UIAlertControllerStyle.alert)
        
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
        
        // Add the text field.
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
            textField.placeholder = "Enter email"
        })
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
            textField.placeholder = " Password "
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
