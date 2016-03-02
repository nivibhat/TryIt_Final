//
//  ForgotPasswordViewController.swift
//  TryIt
//
//  Created by nivedita bhat on 12/1/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Parse
import Social


class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    
    @IBOutlet weak var forgotView: UIView!
    
    @IBAction func ResetBtnPressed(sender: AnyObject) {
        
        
        let userEmail = emailTxtField.text
        
        PFUser.requestPasswordResetForEmailInBackground(userEmail!) { (success:Bool, error:NSError?) -> Void in
            if(success) {
                let smessage = "Email has been sent your email\(userEmail)"
                
                self.displaymessage(smessage)
                return
            }
            if(error != nil) {
                
                let smessage = error?.userInfo["error"] as! String
                
                self.displaymessage(smessage)
                return
            }
            
        }
    }
    
    
    func displaymessage(message :String)
    {
        
        let alert  = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okaction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okaction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
