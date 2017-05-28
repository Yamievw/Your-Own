//
//  WelcomeScreenViewController.swift
//  YamievanWijnbergen-pset6
//
//  ViewController with a navigationsystem for user, and logout button.
//
//  Created by Yamie van Wijnbergen on 28/05/2017.
//  Copyright © 2017 Yamie van Wijnbergen. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function to logout user.
    @IBAction func logOutButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: " Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        let logoutAction = UIAlertAction(title: "Yes",style: .default) { action in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            self.performSegue(withIdentifier: "logIn", sender: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Nope!", style: .default)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
