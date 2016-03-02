//
//  SocialViewController.swift
//  TryIT
//
//  Created by nivedita bhat on 12/7/15.
//  Copyright © 2015 TryIt. All rights reserved.
//

import UIKit
import Parse
import Social


class SocialViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var SocialTableView: UITableView!
    
    var comments: [Comments] = [Comments]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComments()
        
            SocialTableView.separatorStyle = .SingleLine
        
    }
    
    func setupComments() {

        let query = PFQuery(className: "ExpComments")
        query.orderByAscending("createdAt")
        7
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
                          
                            // var  ProfileImage = UIImage(named: "default_profile_pic.jpg")
                            var posteduserId = ""
                            var image : PFFile!
                            var ProfileImage : UIImage!
                            
                            if (comment["ExperienceId"] != nil) {
                                print(comment["ExperienceId"])
                                let ExpQuery = PFQuery(className: "ExperienceList")
                                let experienceId = comment["ExperienceId"] as! String
                                
                                ExpQuery.getObjectInBackgroundWithId(experienceId) { (expobject:PFObject?, error:NSError?) -> Void in
                                    let expName = (expobject?.objectForKey("ExpTitle"))! as! String
                                    
                                    let userId = comment["userId"] as! String
                                    posteduserId = comment["userId"] as! String
                                    
                                    
                                    
                                    let user = PFUser.query()
                                    user!.getObjectInBackgroundWithId(posteduserId, block: { (userObject:PFObject?, error:NSError?) -> Void in
                                        
                                        let username = userObject?.objectForKey("username") as! String

                                        
                                        if(error == nil && userObject != nil) {
                                            
                                            
                                            
                                            
                                            if (userObject?.objectForKey("ProfilePic") != nil) {
                                                image = (userObject?.objectForKey("ProfilePic"))! as! PFFile
                                                image.getDataInBackgroundWithBlock({ (profileData:NSData?, error:NSError?) -> Void in
                                                    ProfileImage  = UIImage(data:profileData!)!
                                                    let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: posteduserId, PostedDate: comment.createdAt!, CmtsonExp: experienceId,profilePic: ProfileImage!
                                                    )
                                                    self.comments.append(commentList!)
                                                    self.SocialTableView.reloadData()
                                                })
                                            } else {
                                                ProfileImage  = UIImage(named: "default_profile_pic.jpg")
                                                print("printing comments details")
                                                print(commentId)
                                                print(comment["Comment"])
                                                print(posteduserId)
                                                print( ProfileImage!)
                                                let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: username, PostedDate: comment.createdAt!, CmtsonExp: experienceId,profilePic: ProfileImage!
                                                )
                                                self.comments.append(commentList!)
                                                self.SocialTableView.reloadData()
                                            }
                                        } else {
                                            ProfileImage  = UIImage(named: "default_profile_pic.jpg")
                                            print("printing comments details")
                                            print(commentId)
                                            print(comment["Comment"])
                                            print(posteduserId)
                                            print( ProfileImage!)
                                            let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: username, PostedDate: comment.createdAt!, CmtsonExp: experienceId,profilePic: ProfileImage!
                                            )
                                            self.comments.append(commentList!)
                                            self.SocialTableView.reloadData()
                                        }
                                    })
                                }
                                
                            } else {
                                let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: posteduserId, PostedDate: comment.createdAt!, CmtsonExp: "General", profilePic: ProfileImage!
                                )
                                
                                self.comments.append(commentList!)
                                self.SocialTableView.reloadData()
                                                        
                                }
                        }
                }
            }
        }
    }
    }
  
//    func setupComments() {
//        let query = PFQuery(className: "ExpComments")
//                query.orderByAscending("createdAt")
//        let posteduserId = ""
//        let commentId = ""
//        let expid = ""
//                query.findObjectsInBackgroundWithBlock{
//                    (comments:[PFObject]?, error: NSError?) -> Void in
//                    if  error != nil {
//                        print(error)
//                    } else {
//                        if comments!.isEmpty {
//                            print("empty query")
//                        } else {
//        
//                            for comment in comments!{
//                                if let commentId = comment.objectId {
//                                    print(commentId)
//                            print(comment.createdAt!)
//                            print(comment["Comment"])
//                                    if (comment["userId"] != nil) {
//                                    let posteduserId = comment["userId"] as! String
//                                } else {
//                                    let posteduserId = "No User"
//                                }
//                                if(comment["ExperienceId"] != nil) {
//                                    let expid = comment["ExperienceId"] as! String
//                                } else {
//                                     let expid = "General Comment"
//                                }
//                                
//                            
//                          //  let profileImage = self.getProfilePic(posteduserId)
//                             var  profileImage = UIImage(named: "default_profile_pic.jpg")
//                            print("printing image")
//                            print(posteduserId)
//                            print(profileImage)
//                                
//                            let commentList = Comments(commentID: commentId, Comments: comment["Comment"] as! String, commentPostedId: posteduserId, PostedDate: comment.createdAt!, CmtsonExp: expid,profilePic: profileImage!
//                            )
//                            self.comments.append(commentList!)
//                            
//                             self.SocialTableView.reloadData()
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
    
    
    func getProfilePic(userId:String) -> UIImage! {
        
        
        //    print("Printing user id that is passed as an argument")
        //    print(userId)
        //    print("Done Printing!!!!!@#$%Z*&^%$")
        //
        
        var  ProfileImage = UIImage(named: "default_profile_pic.jpg")
        print("user id is\(userId)")
        let profileQuery = PFQuery(className: "User")
        profileQuery.whereKey("objectId", equalTo: userId)
        // let image : PFFile!
        
        //  profileQuery.whereKey("userId", equalTo: userId)
        
        profileQuery.findObjectsInBackgroundWithBlock { (profileData:[PFObject]?, errorsP:NSError?) -> Void in
            
            
            // if (errorsP == nil && profileData != nil) {
            
            print("inside profiledata\(profileData?[0])")
            
            for i in 0...profileData!.count - 1 {
                //   for profiled in profileData!  {
                
                print(profileData![i]["username"])
                let image = profileData![i]["ProfilePic"] as! PFFile
                
                print("image isnfbjdfg@#$%^")
                print(image)
                
                image.getDataInBackgroundWithBlock({ (pImage:NSData?, error:NSError?) -> Void in
                    
                    if error != nil {
                        
                        print("some error in image fetching")
                    }
                    else if pImage != nil {
                        
                        print("coming here")
                        
                        ProfileImage  = UIImage(data:pImage!)!
                        
                        self.SocialTableView.reloadData()
                        
                    } else {
                        
                        // ProfileImage = UIImage(named: "default_profile_pic.jpg")
                        
                    }
                    
                })
                
            }
            
            // }
        }
        
        return ProfileImage!
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
        
       // var profilePic = UIImage(named: "default_profile_pic.jpg")
        print("inside cell for row index path")
        let cell: SocialCustomTableViewCell = SocialTableView.dequeueReusableCellWithIdentifier("SocialCell") as! SocialCustomTableViewCell
        
        let cmt = comments[indexPath.row]
   
        print(cmt.CommentID)
        print(cmt.CommentsPostedID)
        print(cmt.Comments)
        
             print("cmts title is")
        print(cmt.CommentsOnExp)
        
        
       // if (cmt.CmtUserProfilePic != nil) {
           let profilePic = cmt.CmtUserProfilePic
        //} else {
          //  profilePic = cmt.CmtUserProfilePic
       // }
        
        cell.setCell(profilePic!,comments: cmt.Comments,posteddate: cmt.CommentsPostedDate,OnExp: cmt.CommentsOnExp)
        
        
        return cell
    }
    
    
   }
