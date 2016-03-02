
//
//  EditProfileViewController.swift
//  TryIt
//
//  Created by nivedita bhat on 11/17/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var firstNametxtfield: UITextField!
    
 
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var emailAddresstxtfield: UITextField!

  //  @IBOutlet weak var passwordtxtfield: UITextField!
    
//    @IBOutlet weak var confirmPasstxtfield: UITextField!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    var opener: ProfileViewController!
    
        let imagePicker = UIImagePickerController()
    var profilepicture: UIImage!
    var imageProfile : PFFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imagePicker.delegate = self
        
        
        
        //----------------------------------------------------------->
        if (PFUser.currentUser()?.objectForKey("username") != nil) {
            let name = PFUser.currentUser()?.objectForKey("username") as! String
            
            self.usernameLbl.text = name
        }
        //----------------------------------------------------------->
        
        
        
        
        
        
        if (PFUser.currentUser()?.objectForKey("name") != nil) {
            let name = PFUser.currentUser()?.objectForKey("name") as! String
            
            self.usernameLbl.text = name
        }
        
        let email = PFUser.currentUser()?.objectForKey("email") as! String
        
        if(PFUser.currentUser()?.objectForKey("ProfilePic") != nil)
        {
            let imageFile:PFFile = PFUser.currentUser()?.objectForKey("ProfilePic") as! PFFile
            imageFile.getDataInBackgroundWithBlock({ (imagedata:NSData?, error:NSError?) -> Void in
                self.profilePic.image = UIImage(data: imagedata!)
            })
        }

        self.emailAddresstxtfield.text = email
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func uploadBtnPressed(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("button captured")
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated : true, completion : nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [String : AnyObject])  {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImageJPEGRepresentation(image, 0.05)
        imageProfile = PFFile(name:"image.jpg", data:imageData!)
        self.profilePic.image = image
        
        profilePic.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func saveBtnPressed(sender: AnyObject) {
        /* if((passwordtxtfield.text!.isEmpty) || (confirmPasstxtfield.text!.isEmpty)) {
        var myalert = UIAlertController(title: "Alert", message: "Password or confirm password is empty", preferredStyle: UIAlertControllerStyle.Alert)
        }
        
        if(passwordtxtfield.text?.isEmpty != confirmPasstxtfield.text?.isEmpty) {
        var myalert = UIAlertController(title: "Alert", message: "Password or confirm password do not match", preferredStyle: UIAlertControllerStyle.Alert)
        } */
        let user:PFUser = PFUser.currentUser()!
        
        // if (profilePic.image != nil)
        //{
        let profileImage = UIImageJPEGRepresentation(profilePic.image!, 1)!
        //} else {
        //  self.profilePic.image = UIImage(named: "TryIt.jpg")
        //  profileImage = UIImageJPEGRepresentation(profilePic.image!, 1)!
        //}
        
        
        let email = emailAddresstxtfield.text
        let name = firstNametxtfield.text
        
        user.setObject(email!, forKey: "email")
        user.setObject(name!, forKey: "Name")
        
        
      //  let userPass = passwordtxtfield.text
        
        
//        PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
//            
//            //         self.actInd.stopAnimating()
//            
//            if ((user) != nil) {
//        
        
        
//        print("password is null")
//        print(userPass)
//        if userPass != nil {
//            user.password = userPass
//        } else {
//            user.password = PFUser.currentUser()?.password
//        }
//        
        //if (profileImage != nil) {
        let profileObject = PFFile(data: profileImage)
        user.setObject(profileObject!, forKey: "ProfilePic")
        //}
        
        // let loadNotification = MBProgressHUD
        
        user.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if(error != nil) {
                print("errorororor")
                let myAlert = UIAlertController(title: "Alert", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                return
            }
            
            if(success)
            {
                print("success")
                let usermessage = "Profile details successfully updated"
                let myalert = UIAlertController(title: "Alert", message: usermessage, preferredStyle: UIAlertControllerStyle.Alert)
                let okaction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        self.opener.setupProfile()
                    })
                })
                myalert.addAction(okaction)
                self.presentViewController(myalert, animated: true, completion: nil)
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
