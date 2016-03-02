//
//  SignUpViewController.swift
//  TryIt
//
//  Created by macbook_user on 11/8/15.
//  Copyright © 2015 TryIt. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SignUpViewController: UIViewController,PFSignUpViewControllerDelegate {
    
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    
    func validateEntries(){}
    
    func createNewUser(username: String, password: String, email: String){}
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        var email = self.emailField.text
        
        
        
        if (username!.characters.count == 0 || password!.characters.count == 0)
        {
            var alert = UIAlertView(title: "Invalid Credentials", message: "All fields must be entered", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        
        else if (username!.characters.count < 4 || password!.characters.count < 4) {
            
            var alert = UIAlertView(title: "Invalid Credentials", message: "Username and Password must be greater than 4 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else if ( isValidEmail(email!) == false){
            
            var alert = UIAlertView(title: "Invalid", message: "Please enter a valid Email.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else {
            
      //      self.actInd.startAnimating()
            
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
       //         self.actInd.stopAnimating()
                
                if ((error) != nil) {
                    
                    var alert = UIAlertView(title: "Error", message: "\(error?.description )", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }else {
                    
                    self.performSegueWithIdentifier("back_login", sender: self)
                    
                    
//                    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//                    if segue.identifier == "back_login" {
//                        let back_login = segue.destinationViewController as! signInViewController
//                       // back_login.delegate = self
//                        //self.experienceDelegate = back_login
//                    }
//
//                    }
//                    var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
//                    alert.show()
                    
                }
                
            })
            
        }
        
    }
    

}
