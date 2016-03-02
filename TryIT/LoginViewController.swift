//
//  LoginViewController.swift
//  TryIT
//
//  Created by macbook_user on 12/4/15.
//  Copyright © 2015 TryIt. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LoginViewController: UIViewController, PFLogInViewControllerDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    /*override func viewDidLoad() {
    //Check if user exists and logged in
    if let user = PFUser.currentUser() {
    if user.isAuthenticated() {
    self.performSegueWithIdentifier("loginsuccessful", sender: nil)
    }
    if(PFUser.currentUser() != nil){
    print("here already")
    gotoList()
    
    }
    
    }
    
    }*/
    
    
    override func viewDidAppear(animated: Bool) {
        
        print("current user passwor dis")
        print(PFUser.currentUser())
        
        if(PFUser.currentUser() != nil){
            print("view appeared")
            
            
            //UNCOMMENT THIS TO MAKE AUTOLOGIN 
            //********!$#%%#$% IMPORTANT %$#$%$#
            
            
            
            
            gotoList()
            
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username!.characters.count == 0 || password!.characters.count == 0)
        {
            let alert = UIAlertView(title: "Invalid Credentials", message: "All fields must be entered", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if (username!.characters.count < 4 || password!.characters.count < 4) {
            
            let alert = UIAlertView(title: "Invalid Credentials", message: "Username and Password must be greater than 4 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else {
            
            //    self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                //         self.actInd.stopAnimating()
                
                if ((user) != nil) {
                    
                    print("success login")
                    
                    
                    
                    //uncomment this to make Login Work
                    
                    
                    self.performSegueWithIdentifier("loginsuccessful", sender: self)
                    //                        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                    //
                    //                            if segue.identifier == "loginsuccessful" {
                    //                                let loginsuccessful = segue.destinationViewController as! ExperienceListViewController
                    //                                // back_login.delegate = self
                    //                                //self.experienceDelegate = back_login
                    print("success login 2")
                    
                    
                    
                    
                    
                    //
                    //                        let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    //                        alert.show()
                    // self.gotoList()
                    
                }else {
                    
                    let alert = UIAlertView(title: "Error", message: "\(error?.localizedDescription )", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    print("unsuccessful")
                }
                
            })
            
        }
        
    }
    
    
    func gotoList(){
        
        performSegueWithIdentifier("loginsuccessful", sender: self)
        
    }
    
    
    
    
    
    
    
}
