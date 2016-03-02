//
//  ExpCommentsViewController.swift
//  TryIt
//
//  Created by nivedita bhat on 12/3/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Parse
import Social

class ExpCommentsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

      var expImage1:UIImage!
    
    @IBOutlet weak var expimageview: UIImageView!
    
    @IBOutlet weak var expCmtTableView: UITableView!
    @IBOutlet weak var Commentstxtview: UITextView!
    
    var comments: [Comments] = [Comments]()
    var experienceInfo : ExperienceModel!
    var experienceObject : PFObject!
    var experienceId: String = ""
    var expobjectid : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          setupContents()
        setupComments()
    }
    
    
    @IBAction func ShareBtnClicked(sender: AnyObject) {
        
        let writtentext = Commentstxtview.text
        print("texts typed")
        print(writtentext)
        let user = PFUser.currentUser()?.objectId
        
        self.experienceId = experienceInfo.experienceObjectID
        
        print("experience id is")
        print(experienceId)
        
        if(experienceObject!["objectId"] != nil) {
            self.expobjectid = experienceObject!["objectId"] as! String
            print("experience id is")
            print(self.expobjectid)
        }
        
        let cmtObject = PFObject(className: "ExpComments")
        cmtObject.setObject(user!, forKey: "userId")
        cmtObject.setObject(experienceId, forKey: "ExperienceId")
        cmtObject.setObject(writtentext!, forKey: "Comment")
        
        
        cmtObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if(success) {
                print("hurrey")
                self.Commentstxtview.text = " "
                self.setupComments()
                self.expCmtTableView.reloadData()
            }
            if((error) != nil) {
                print("saad")
            }
        }
    }
    
     func setupContents(){
        let expImageFile1 = experienceObject!["Image1"] as! PFFile
        expImageFile1.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            
            if error == nil && imageData != nil {
                self.expImage1  = UIImage(data:imageData!)!
                self.expimageview.image = self.expImage1
            }
        }
    }
    
    func setupComments() {
        self.experienceId = experienceInfo.experienceObjectID
                let query = PFQuery(className: "ExpComments")
                query.whereKey("ExperienceId", equalTo: self.experienceId)
            print("experience is inside setup comments \(self.experienceId)")
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
                                var image : PFFile!
                                var ProfileImage : UIImage!
                                let posteduserId = comment["userId"] as! String
                               // let user = PFQuery(className: "User")
                                let user = PFUser.query()
                                user!.getObjectInBackgroundWithId(posteduserId, block: { (userObject:PFObject?, error:NSError?) -> Void in
                                    if(error == nil && userObject != nil) {
                                        if (userObject?.objectForKey("ProfilePic") != nil) {
                                            image = (userObject?.objectForKey("ProfilePic"))! as! PFFile
                                            image.getDataInBackgroundWithBlock({ (profileData:NSData?, error:NSError?) -> Void in
                                                ProfileImage  = UIImage(data:profileData!)!
                                                let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: posteduserId, PostedDate: comment.createdAt!, CmtsonExp: self.experienceId,profilePic: ProfileImage!
                                        )
                                        self.comments.append(commentList!)
                                        self.expCmtTableView.reloadData()
                                    })
                                        } else {
                                            ProfileImage  = UIImage(named: "default_profile_pic.jpg")
                                            print("printing comments details")
                                            print(commentId)
                                            print(comment["Comment"])
                                            print(posteduserId)
                                            print( ProfileImage!)
                                            let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: posteduserId, PostedDate: comment.createdAt!, CmtsonExp: self.experienceId,profilePic: ProfileImage!
                                            )
                                            self.comments.append(commentList!)
                                            self.expCmtTableView.reloadData()
                                        }
                                    } else {
                                        ProfileImage  = UIImage(named: "default_profile_pic.jpg")
                                        print("printing comments details")
                                        print(commentId)
                                        print(comment["Comment"])
                                        print(posteduserId)
                                        print( ProfileImage!)
                                        let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: posteduserId, PostedDate: comment.createdAt!, CmtsonExp: self.experienceId,profilePic: ProfileImage!
                                        )
                                        self.comments.append(commentList!)
                                        self.expCmtTableView.reloadData()
                                    }
                                })
                               
                                
                            }
                        }
                    }
                }
            }
      }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        print("numer of rows")
        print(comments.count)
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // let cell:UITableViewCell = profileCommentsTableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath)
        
        
        var profilePic = UIImage(named: "default_profile_pic.jpg")
        

        print("inside cell for row index path")
        let cell: ExpCommentsTableViewCell = expCmtTableView.dequeueReusableCellWithIdentifier("CmtExpCell") as! ExpCommentsTableViewCell
        
        let cmt = comments[indexPath.row]
        print("cmt")
        print(cmt.CommentID)
        print(cmt.CommentsPostedID)
        print(cmt.Comments)
        
        if (cmt.CmtUserProfilePic != nil) {
            profilePic = cmt.CmtUserProfilePic
        }
              cell.setCell(profilePic!,comments: cmt.Comments)
        
        return cell
    }

    
}
