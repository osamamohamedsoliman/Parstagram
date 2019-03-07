//
//  logInViewController.swift
//  parstagram
//
//  Created by Osama Soliman on 3/5/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit
import Parse

class logInViewController: UIViewController {
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignin(_ sender: Any) {
        let user = userName.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: user, password: password) { (user, error) in
            if( user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let  user = PFUser()
        user.username = userName.text
        user.password = passwordField.text
        user.signUpInBackground { (success, error) in
            if (success){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error :  \(String(describing: error?.localizedDescription))")
            }
        }
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
