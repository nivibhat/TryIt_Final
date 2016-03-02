//
//  ProfileViewController.swift
//  TryIt
//
//  Created by nivedita bhat on 10/30/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Social


class ProfileViewController : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate,UITableViewDataSource  {
    
    var comments: [Comments] = [Comments]()
    
    @IBOutlet weak var cmtExistlbl: UILabel!
     var MyTriedexperiences: [MyList] = [MyList]()
     var myTriedListids:[String]! = []

    var triedCountpassed :String!

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var profilePic: UIImageView!

    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var triedCountlbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
     var profilepicture = UIImage(named: "default_profile_pic.jpg")
    var imageProfile : PFFile!
    @IBOutlet weak var profileCommentsTableView: UITableView!
    
    var userId : String = ""
    
    
    override func viewWillAppear(animated: Bool) {
        setupProfile()
       // setupComments()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupComments()
        if (comments.count == 0) {
            print(comments.count)
            print("nope")
            //self.cmtExistlbl.text = "You have not made any comments yet!"
        }
        else {
            print(comments.count)
            print("yess")
            self.cmtExistlbl.text = "else part running"
        }
        
        myTriedListids = PFUser.currentUser()!.objectForKey("triedExplist")as? Array<String>
        
      print("tried count is")
       // print(myTriedListids.count)
        
        if (myTriedListids != nil) {
            self.triedCountlbl.text = String(myTriedListids.count)
            print(self.triedCountlbl.text)
        } else {
            self.triedCountlbl.text = "0"
        }
       // setupProfile()
       //setupComments()
    }
    
    
    @IBAction func SegmentedIndexChanged(sender: UISegmentedControl) {
        
        switch SegmentedControl.selectedSegmentIndex
        {
        case 0:
            let editProfile = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfileViewController") as! EditProfileViewController
            
            editProfile.opener = self
            let editProfileNav = UINavigationController(rootViewController: editProfile)
            self.presentViewController(editProfileNav, animated: true, completion: nil)
            break
        case 1:
            self.performSegueWithIdentifier("MyWishlist", sender: self)
            break
        case 2:
            let TriedList = self.storyboard?.instantiateViewControllerWithIdentifier("MyTriedListViewController") as! MyTriedListViewController
            
            TriedList.TriedListopener = self
            let TriedListNav = UINavigationController(rootViewController: TriedList)
            self.presentViewController(TriedListNav, animated: true, completion: nil)
            
            //self.performSegueWithIdentifier("MyTriedList", sender: self)
            break
        default:break
            
        }
    }
    

    @IBAction func editProfilepressed(sender: AnyObject) {
        
        let editProfile = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfileViewController") as! EditProfileViewController
        
        editProfile.opener = self
        let editProfileNav = UINavigationController(rootViewController: editProfile)
        self.presentViewController(editProfileNav, animated: true, completion: nil)
        
    }
  
    func setupComments() {

        let query = PFQuery(className: "ExpComments")
        query.whereKey("userId", equalTo: (PFUser.currentUser()?.objectId)!)
        
        let postedby = PFUser.currentUser()?.objectId
        
        
        query.findObjectsInBackgroundWithBlock{
            (comments:[PFObject]?, error: NSError?) -> Void in
            
            if  error != nil {
                print(error)
            } else {
                if comments!.isEmpty {
                    print("empty query")
                } else {
            
                for comment in comments!{
                    
                    if let commentId = comment.objectId {
                        
                        print(commentId)
                        
                    print(comment.createdAt!)
                    print(comment["Comment"])
                        print("experience id is")
                        print(comment["ExperienceId"])
                        print("picture is")
                       
                        print(self.profilepicture)
                        let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: postedby!, PostedDate: comment.createdAt!, CmtsonExp: comment["ExperienceId"] as! String,profilePic: self.profilepicture!)
                        self.comments.append(commentList!)
                          print("count is is")
                        print(comments?.count)
                        
                        
                        self.profileCommentsTableView.reloadData()
                    }
                }
            }
        }
    }
    }

 
    @IBAction func logoutBtnPressed(sender: AnyObject) {
        
        PFUser.logOut()
    }
    func setupProfile() {
        
        // self.userNamelbl.text = NSUserName()
        // print(NSUserName())
        
        // var query = PFQuery(className:"User")
        let query = PFUser.query()
       // query!.whereKey("email", equalTo: "nivedita02@gmail.com")
        print(PFUser.currentUser()?.objectId)
        
        imagePicker.delegate = self
        
        if (PFUser.currentUser()?.objectForKey("username") != nil) {
            let name = PFUser.currentUser()?.objectForKey("username") as! String
            self.userNamelbl.text = name
        }
        
        let email = PFUser.currentUser()?.objectForKey("email") as! String
        
        if(PFUser.currentUser()?.objectForKey("ProfilePic") != nil)
        {
            let imageFile:PFFile = PFUser.currentUser()?.objectForKey("ProfilePic") as! PFFile
            imageFile.getDataInBackgroundWithBlock({ (imagedata:NSData?, error:NSError?) -> Void in
                
                if (imagedata != nil) {
                self.profilePic.image = UIImage(data: imagedata!)
                self.profilepicture = UIImage(data: imagedata!)
                } else {
                     self.profilePic.image = UIImage(named: "default_profile_pic.jpg")
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
         // print("numer of rowshhhhh")
          //print(comments.count)
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {

        print("inside cell for row index path")
        let cell: ProfileTableViewCustomCell = profileCommentsTableView.dequeueReusableCellWithIdentifier("profileCell") as! ProfileTableViewCustomCell
        
    
        cell.DeleteCmtBtn.tag = indexPath.row
        cell.DeleteCmtBtn.addTarget(self, action: "deletCmtAction:", forControlEvents: .TouchUpInside)
        
        let cmt = comments[indexPath.row]
        print("cmt")
        print(cmt.CommentID)
        print(cmt.CommentsPostedID)
        print(cmt.Comments)
        cell.setCell(self.profilePic.image!,comments: cmt.Comments,posteddate: cmt.CommentsPostedDate,OnExp: cmt.CommentsOnExp)
        
        return cell
    }
    
    @IBAction func deletCmtAction(sender:UIButton!)
    {
        print("sender informaiton")
        print(sender.tag)
        let cmt = comments[sender.tag]
        print(cmt.CommentID)
        
        let cmtquery = PFQuery(className: "ExpComments")
        cmtquery.whereKey("objectId", equalTo: cmt.CommentID)
        cmtquery.findObjectsInBackgroundWithBlock { (cmtObject:[PFObject]?, error:NSError?) -> Void in
            if (cmtObject != nil) {
                for obj in cmtObject! {
                    obj.deleteInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        if (success) {
                            print("deleted")
                        }
                        if(error != nil) {
                            print("not deleted")
                        }
                    })
                }
            }
        }
        self.profileCommentsTableView.reloadData()
    
    }
    
    func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }
    
}
