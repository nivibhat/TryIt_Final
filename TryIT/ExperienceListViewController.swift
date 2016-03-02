//
//  ExperienceListViewController.swift
//  TryIt
//
//  Created by Jingwei Ji on 11/9/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Social
import Parse




protocol ExperienceListViewControllerDelegate{
    func experienceDownloadFinished()
}

class ExperienceListViewController: UIViewController,containerDelegate {

    @IBOutlet weak var ExperienceListTableView: UITableView!
    
    var experiences: [ExperienceModel] = [ExperienceModel]()
    var listOfPFObject : [PFObject]! = []
    var listOfCategory : [String]! = ["All"]
    var selectedListOfPFObject :[PFObject]! = []
    var selectedexperiences : [ExperienceModel]! = []
    var userPreferrenceModel : userPreferrence!
      var myWishListids:[String]! = []
    
    var selectedExperienceObjectId:String = ""
    
    var parseObject:PFObject?
    
    //delegate need to inform container vc that downloads are finished
    var experienceDelegate : ExperienceListViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExperienceListTableView.separatorStyle = .None
        
        setupExperiences()
        
        
        print("\n\n\n\n\n\n\nDone Setting Cells")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        userPreferrenceModel = userPreferrence()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setupExperiences(category : String = "All")
    {
        
        let query = PFQuery(className: "ExperienceList")
        
        if category == "All"{
            //dispatch_sync(dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)) {
                //for now, only download 30 events
                query.limit = 30
                
                //first need to check if "all" tab is already loaded

                if (self.listOfPFObject.count <= 0 || self.experiences.count <= 0){
                    query.findObjectsInBackgroundWithBlock{
                        (experienceData:[PFObject]?, error: NSError?) -> Void in
                        
                        if  error == nil && experienceData != nil {
                            
                            for i in 0...experienceData!.count - 1 {
                                
                                //                    let Exp1 = Experience(experienceTitle: exp["ExpTitle"]as! String, experienceImage: UIImage(named: "testImg1.png"), experienceDate: "12/30/2000", experienceAddress: "123Street")
                                
                                var expImage:UIImage = UIImage()
                                
                                
                                
                                let expImageFile = experienceData![i]["Image1"] as! PFFile
                                
                                
                                
                                expImageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                    
                                    
                                    
                                    if error == nil && imageData != nil {
                                        expImage  = UIImage(data:imageData!)!
                                        
                                        // do something with image here
                                    }
                                    
                                    
                                    
                                    let date = experienceData![i]["StartDate"]as! NSDate //get the time, in this case the time an object was created.
                                    
                                    //format date
                                    let dateFormatter = NSDateFormatter()
                                    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
                                    dateFormatter.dateFormat = "MM'-'dd HH':'mm" //format style. Browse online to get a format that fits your needs.
                                    let dateString = dateFormatter.stringFromDate(date)
                                    
                                    //create a list of categories
                                    let category = experienceData![i]["ExpCategory"] as! String
                                    if !self.listOfCategory.contains(category){
                                        self.listOfCategory.append(category)

                                    }
                                    
                                    let experience = ExperienceModel(experienceObjectID:experienceData![i].objectId! , experienceTitle:experienceData![i]["ExpTitle"]as! String , experienceImage: expImage, experienceDate: dateString, category: category)
                                    
                                    self.listOfPFObject.append(experienceData![i])
                                    self.experiences.append(experience!)
                                  
                                    self.selectedListOfPFObject = self.listOfPFObject
                                    self.selectedexperiences = self.experiences
                                    
                                    self.ExperienceListTableView.reloadData()
                                    //save list of categorys to userdefaults, so that container can render it
                                    if i == experienceData!.count - 1 {
                                        self.userPreferrenceModel.userInterestedInCategories = self.listOfCategory
                                        self.userPreferrenceModel.save()
                                        self.experienceDelegate?.experienceDownloadFinished()
                                        
                                    }
                                }
                                
                            }

                        }
                        else{
                            print(error)
                            
                        }
                    }
                    
                }
                else{
                    selectedexperiences = self.experiences
                    selectedListOfPFObject = self.listOfPFObject
                    self.ExperienceListTableView.reloadData()   
                }

                
            //}
            //main queue comes

            
        }
        
        else{
            //if user tap a different category, dump events in that category into selected list
            selectedListOfPFObject = []
            selectedexperiences = []
            for i in 0...self.experiences.count - 1  {
                if self.experiences[i].category == category{
                    selectedexperiences.append(self.experiences[i])
                    selectedListOfPFObject.append(self.listOfPFObject[i])
                    
                }
            }
            self.ExperienceListTableView.reloadData()
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
    func categoryIsSelected(category: String){
        //print("\(category) is chosen")
        
        setupExperiences(category)
    }

}

//extension ExperienceListViewController : UITableViewDataSource, UITableViewDelegate {
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return selectedexperiences.count
//    }
//    
//    
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ExperienceTableViewCell
//        
//        // Configure the cell...
//        //cell.textLabel?.text = appList[indexPath.row]
//        
//        cell.bkImageView.image = selectedexperiences[indexPath.row].experienceImage
//        
//        
//        cell.contentMode = UIViewContentMode.ScaleAspectFit ;
//        
//        
//        
//        
//        
//        
//        cell.titleLable.text = selectedexperiences[indexPath.row].experienceTitle
//        cell.dateLabel.text = selectedexperiences[indexPath.row].experienceDate
//        let id = selectedexperiences[indexPath.row].experienceObjectID
//        
//        
//        cell.likeBtn.tag = indexPath.row
//        cell.likeBtn.addTarget(self, action: "likeBtnAction:", forControlEvents: .TouchUpInside)
//        
//        cell.commentExpBtn.tag = indexPath.row
//        cell.commentExpBtn.addTarget(self, action: "commentBtnAction:", forControlEvents: .TouchUpInside)
//        
//        
//        print(id)
//        let pfobject = PFQuery(className: "ExperienceList")
//        pfobject.whereKey("objectId", equalTo: id)
//        var like: Int? = 0
//        
//         myWishListids = PFUser.currentUser()!.objectForKey("myWishList")as? Array<String>
//        if (myWishListids != nil) {
//        if myWishListids.contains(id) {
//            print("experienced liked by the user")
//            cell.likeBtn.alpha = 0.2
//        }
//        }
//        
//        
//        pfobject.findObjectsInBackgroundWithBlock { ( totallikes:[PFObject]?, error:NSError?) -> Void in
//            if (error == nil && totallikes != nil) {
//                for likes in totallikes! {
//                    like = likes["TotalLikes"] as? Int
//
//                    if (like != nil)
//                    {
//                    print(like)
//                    cell.totalLikeslbl.text! = String(like!)
//                      print(cell.totalLikeslbl.text)
//                    } else {
//                        print(" 0 likes ")
//                        cell.totalLikeslbl.text = "0"
//                    }
//                }
//            }
//        }
//        return cell
//    }
//    
//  
//    @IBAction func likeBtnAction(sender:UIButton!) {
//        
//         let id = selectedexperiences[sender.tag].experienceObjectID
//        let querylike = PFQuery(className: "ExperienceList")
//        querylike.whereKey("objectId", equalTo: id)
//        var totallike: Int? = 0
//        
//        //update the like count in experience list class
//        
//        querylike.findObjectsInBackgroundWithBlock { ( totallikes:[PFObject]?, error:NSError?) -> Void in
//            if (error == nil && totallikes != nil) {
//              
//                for likes in totallikes! {
//                    let like = likes["TotalLikes"] as? Int
//                    
//                    print("total likes")
//                    
//                    print(like)
//                    if (like == nil) {
//                        totallike = 1 
//                    } else {
//                        totallike = like! + 1                        
//                    }
//                }
//                
//                print("total like after saving")
//                        print(totallike)
//                let object :PFObject = PFObject(withoutDataWithClassName: "ExperienceList", objectId: id)
//                
//                object.setObject(totallike!, forKey: "TotalLikes")
//                
//                object.saveInBackgroundWithBlock { (var success:Bool, error:NSError?) -> Void in
//                    if (success) {
//                        print("hip hip")
//                        self.ExperienceListTableView.reloadData()
//                        success = true
//                        sender.alpha = 0.2
//                        
//                    }
//                    if ((error) != nil) {
//                        print("saad\(error)")
//                        success = false
//                        
//                    }
//                }
//            }
//        }
//        
//        //update the users class's Wishlist
//        
//        let user:PFUser = PFUser.currentUser()!
//        
//        //the below one also works
//        user.addUniqueObjectsFromArray([id], forKey: "myWishList")
//        user.saveInBackground()
//        
//        
//    }
extension ExperienceListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return selectedexperiences.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ExperienceTableViewCell
        
        // Configure the cell...
        //cell.textLabel?.text = appList[indexPath.row]
        
        cell.bkImageView.image = selectedexperiences[indexPath.row].experienceImage
        cell.titleLable.text = selectedexperiences[indexPath.row].experienceTitle
        cell.dateLabel.text = selectedexperiences[indexPath.row].experienceDate
        let id = selectedexperiences[indexPath.row].experienceObjectID
        
        //this is to use to add the buttons action to tableviewcell
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: "likeBtnAction:", forControlEvents: .TouchUpInside)
        
        cell.unlikeBtn.tag = indexPath.row
        cell.unlikeBtn.addTarget(self, action: "UnlikeBtnAction:", forControlEvents: .TouchUpInside)
        
        
        cell.commentExpBtn.tag = indexPath.row
        cell.commentExpBtn.addTarget(self, action: "commentBtnAction:", forControlEvents: .TouchUpInside)
        
        
        print(id)
        let pfobject = PFQuery(className: "ExperienceList")
        pfobject.whereKey("objectId", equalTo: id)
        var like: Int? = 0
        
        myWishListids = PFUser.currentUser()!.objectForKey("myWishList")as? Array<String>
        if (myWishListids != nil) {
            if myWishListids.contains(id) {
                print("experience liked by the user")
                if let image = UIImage(named: "thumbsdown.png") {
                    cell.unlikeBtn.setImage(image, forState: .Normal)
                    
                }
                cell.unlikeBtn.alpha = 1.0
                
                cell.likeBtn.alpha = 0.0
                
            } else {
                if let image = UIImage(named: "thumbsup.png") {
                    cell.likeBtn.setImage(image, forState: .Normal)
                }
                cell.unlikeBtn.alpha = 0.0
                
                cell.likeBtn.alpha = 1.0
            }
        } else {
            cell.unlikeBtn.alpha = 0.0
            
            cell.likeBtn.alpha = 1.0
        }
        
        pfobject.findObjectsInBackgroundWithBlock { ( totallikes:[PFObject]?, error:NSError?) -> Void in
            if (error == nil && totallikes != nil) {
                for likes in totallikes! {
                    like = likes["TotalLikes"] as? Int
                    
                    if (like != nil)
                    {
                        print(like)
                        cell.totalLikeslbl.text! = String(like!)
                        print(cell.totalLikeslbl.text)
                    } else {
                        print(" 0 likes ")
                        cell.totalLikeslbl.text = "0"
                    }
                }
            }
        }
        
        // get the total number of comments on each experience
        var commentCount : Int = 0
        let query = PFQuery(className: "ExpComments")
        query.whereKey("ExperienceId", equalTo: id)
        print("experience is inside setup comments \(id)")
        query.findObjectsInBackgroundWithBlock{
            (comments:[PFObject]?, error: NSError?) -> Void in
            
            if  error != nil {
                print(error)
            } else if comments!.isEmpty {
                print("empty query")
            } else {
                
                for comment in comments!{
                    if let commentId = comment.objectId {
                        print(commentId)
                        print(comment.createdAt!)
                        print(comment["Comment"])
                        commentCount++
                    }
                }
            }
            print("total comment count")
            print(commentCount)
            cell.commentCount.text = String(commentCount)
        }
        return cell
    }
    
    @IBAction func UnlikeBtnAction(sender:UIButton!) {
        let id = selectedexperiences[sender.tag].experienceObjectID
        let querylike = PFQuery(className: "ExperienceList")
        querylike.whereKey("objectId", equalTo: id)
        var totallike: Int? = 0
        
        myWishListids = PFUser.currentUser()!.objectForKey("myWishList")as? Array<String>
        
        if((myWishListids != nil && myWishListids.contains(id))) {
            
            querylike.findObjectsInBackgroundWithBlock { ( totallikes:[PFObject]?, error:NSError?) -> Void in
                if (error == nil && totallikes != nil) {
                    
                    for likes in totallikes! {
                        let like = likes["TotalLikes"] as? Int
                        
                        print("total likes")
                        
                        print(like)
                        if (like == nil) {
                            totallike = 1
                        } else {
                            totallike = like! - 1
                        }
                    }
                    let object :PFObject = PFObject(withoutDataWithClassName: "ExperienceList", objectId: id)
                    
                    object.setObject(totallike!, forKey: "TotalLikes")
                    
                    object.saveInBackgroundWithBlock { (var success:Bool, error:NSError?) -> Void in
                        if (success) {
                            print("hip hip")
                            self.ExperienceListTableView.reloadData()
                            success = true
                            if let image = UIImage(named: "tumbsup.png") {
                                sender.setImage(image, forState: .Normal)
                            }
                            sender.alpha = 0.0
                            
                        }
                        if ((error) != nil) {
                            print("saad\(error)")
                            success = false
                            
                        }
                    }
                }
            }
            
            let user:PFUser = PFUser.currentUser()!
            user.removeObjectsInArray([id], forKey: "myWishList")
            user.saveInBackground()
        }
    }
    
    
    @IBAction func likeBtnAction(sender:UIButton!) {
        
        let id = selectedexperiences[sender.tag].experienceObjectID
        let querylike = PFQuery(className: "ExperienceList")
        querylike.whereKey("objectId", equalTo: id)
        var totallike: Int? = 0
        
        //update the like count in experience list class
        
        myWishListids = PFUser.currentUser()!.objectForKey("myWishList")as? Array<String>
        
        if(myWishListids == nil) || (myWishListids != nil && !myWishListids.contains(id)) {
            
            querylike.findObjectsInBackgroundWithBlock { ( totallikes:[PFObject]?, error:NSError?) -> Void in
                if (error == nil && totallikes != nil) {
                    
                    for likes in totallikes! {
                        let like = likes["TotalLikes"] as? Int
                        
                        print("total likes")
                        
                        print(like)
                        if (like == nil) {
                            totallike = 1
                        } else {
                            totallike = like! + 1
                        }
                    }
                    
                    print("total like after saving")
                    print(totallike)
                    let object :PFObject = PFObject(withoutDataWithClassName: "ExperienceList", objectId: id)
                    
                    object.setObject(totallike!, forKey: "TotalLikes")
                    
                    object.saveInBackgroundWithBlock { (var success:Bool, error:NSError?) -> Void in
                        if (success) {
                            print("hip hip")
                            self.ExperienceListTableView.reloadData()
                            success = true
                            //                        if let image = UIImage(named: "thumsbdown.png") {
                            //                            sender.setImage(image, forState: .Normal)
                            //                        }
                            sender.alpha = 0.0
                            
                        }
                        if ((error) != nil) {
                            print("saad\(error)")
                            success = false
                            sender.alpha = 1.0
                            
                        }
                    }
                }
            }
            
            //update the users class's Wishlist
            
            let user:PFUser = PFUser.currentUser()!
            
            user.addUniqueObjectsFromArray([id], forKey: "myWishList")
            user.saveInBackground()
            
            
        }
    }
    
    @IBAction func commentBtnAction(sender:UIButton!) {
        
         self.performSegueWithIdentifier("ExpComments", sender: sender)

        
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let moreAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "not Interested") { (action , indexPath ) -> Void in
            //self.editing = false
            print("More button pressed")
            
        }
        moreAction.backgroundColor = UIColor.greenColor()
        
        /*let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share") { (action , indexPath) -> Void in
        //self.editing = false
        print("Share button pressed")
        }
        shareAction.backgroundColor = UIColor.blueColor()
        */
        
        let twitterClosure = { (action: UIAlertAction!) -> Void in
            let shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            shareToTwitter.setInitialText("#tryitapp #\(self.removeSpace(self.selectedexperiences[indexPath.row].experienceTitle)) ")
            
            
            self.presentViewController(shareToTwitter, animated: true, completion: nil)
        }
        
        
        let facebookClosure = { (action: UIAlertAction!) -> Void in
            let shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            shareToFacebook.setInitialText("#tryitapp #\(self.removeSpace(self.selectedexperiences[indexPath.row].experienceTitle)) ")
            
            
            self.presentViewController(shareToFacebook, animated: true, completion: nil)
        }
        
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: twitterClosure)
            let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: facebookClosure)
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(cancelAction)
            
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        
        
        return [moreAction,shareAction]
    }

    func removeSpace(str: String) -> String {
        let unsafeChars = NSCharacterSet.alphanumericCharacterSet().invertedSet
        return str.componentsSeparatedByCharactersInSet(unsafeChars).joinWithSeparator("")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailViewControllerSegue" {
            
//            
//            var selectedExperienceVC:ExperienceDetailViewController = segue.destinationViewController as! ExperienceDetailViewController
//            //
//            selectedExperienceVC.ExperienceObjectID = self.selectedExperienceObjectId
//            
//            
//            
            
            
            print("\n\n\n\n\n\n\n\n\n\n\n\n\nstarting to print MAJOR STUFF")
            
            let indexPath : NSIndexPath = self.ExperienceListTableView.indexPathForSelectedRow!
            let destViewController = segue.destinationViewController as! ExperienceDetailViewController
           // let experienceObject = self.selectedListOfPFObject![indexPath.row]
            //destViewController.experienceObject = experienceObject
            //destViewController.experienceInfo = self.selectedexperiences![indexPath.row]
            print(self.selectedexperiences![indexPath.row].experienceObjectID)
            destViewController.ExperienceObjectID = self.selectedexperiences![indexPath.row].experienceObjectID
           print("done Printing Useful Stuff")
            
        }
        if segue.identifier == "container" {
            let container = segue.destinationViewController as! containerViewController
            container.delegate = self
            self.experienceDelegate = container
        }
        if segue.identifier == "ExpComments" {
            print("inside prepare for segue")
            let indexPath : NSIndexPath //= self.ExperienceListTableView.indexPathForSelectedRow!
            if let button = sender as?  UIButton {
                
                let cell = button.superview?.superview as! ExperienceTableViewCell
                //indexPath = self.tableView.indexPathForCell(cell)
                indexPath = self.ExperienceListTableView.indexPathForCell(cell)!
            
                let destCmtViewController = segue.destinationViewController as! ExpCommentsViewController
                print("destCmtViewController")
                print(destCmtViewController)
                let experienceObject = self.selectedListOfPFObject![indexPath.row]
                destCmtViewController.experienceObject = experienceObject
                destCmtViewController.experienceInfo = self.selectedexperiences![indexPath.row]
           
            }
        }
        }
}
