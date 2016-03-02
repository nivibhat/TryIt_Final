//
//  MyTriedListViewController.swift
//  TryIt
//
//  Created by nivedita bhat on 11/30/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Parse
import Social

class MyTriedListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var MyTriedListTableView: UITableView!
    
    var MyTriedexperiences: [MyList] = [MyList]()
    
    @IBOutlet weak var MytriedExistencelbl: UILabel!
    var myTriedListids:[String]! = []
    
    var TriedListopener: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyTridList()
        
    }
        func setupMyTridList() -> String {
            myTriedListids = PFUser.currentUser()!.objectForKey("triedExplist")as? Array<String>
            var i = 0
            if (myTriedListids != nil) {
                self.MytriedExistencelbl.text = "You have experienced these!"
                while (i < myTriedListids.count)
                {
                let query = PFQuery(className: "ExperienceList")
                query.whereKey("objectId", equalTo: myTriedListids[i])
                query.findObjectsInBackgroundWithBlock{
                    (experienceData:[PFObject]?, error: NSError?) -> Void in
                    
                    if (error != nil) {
                        print ("error")
                    } else if (experienceData == nil) {
                        print ("exprience null")
                    } else {
                        for exp in experienceData! {
                            print("inside")
                            var expImage:UIImage = UIImage()
                            let expImageFile = exp["Image1"] as! PFFile
                            
                            expImageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                
                                if error == nil && imageData != nil {
                                    expImage  = UIImage(data:imageData!)!
                                    print(expImage)
                                    
                                    
                                    let Exptitle = exp["ExpTitle"]
                                    print(Exptitle)
                                    let date = exp["StartDate"]as! NSDate //get the time, in this case
                                    let dateFormatter = NSDateFormatter()
                                    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
                                    dateFormatter.dateFormat = "MM'-'dd HH':'mm" //format style. Browse online to get a format that fits your needs.
                                    let dateString = dateFormatter.stringFromDate(date)
                                    let explocation = exp["Location"]
                                    print(explocation)
                                    
                                    let MyWishList = MyList(experienceObjectID: exp.objectId!, experienceTitle: Exptitle as! String, experienceImage: expImage, experienceDate: dateString, location: explocation as! String)
                                    
                                    self.MyTriedexperiences.append(MyWishList!)
                                    
                                    print(self.MyTriedexperiences.count)
                                    self.MyTriedListTableView.reloadData()
                                    
                                }
                            }
//                           let Exptitle = exp["ExpTitle"]
//                            print(Exptitle)
//                            let date = exp["StartDate"]as! NSDate //get the time, in this case
//                            let dateFormatter = NSDateFormatter()
//                            dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
//                            dateFormatter.dateFormat = "MM'-'dd HH':'mm" //format style. Browse online to get a format that fits your needs.
//                            let dateString = dateFormatter.stringFromDate(date)
//                            let explocation = exp["Location"]
//                            print(explocation)
//                            
//                            let MyWishList = MyList(experienceObjectID: exp.objectId!, experienceTitle: Exptitle as! String, experienceImage: expImage, experienceDate: dateString, location: explocation as! String)
//                            
//                            self.MyTriedexperiences.append(MyWishList!)
//
//                            print(self.MyTriedexperiences.count)
//                            self.MyTriedListTableView.reloadData()
                        }
                    }
                }
                
                i = i + 1
             }
            } else {
                self.MytriedExistencelbl.text = "You have not tried any experience yet!"
            }
            if(self.MyTriedexperiences.count != 0) {
                print("coming here")
                print(self.MyTriedexperiences.count)
                return String(self.MyTriedexperiences.count)
            } else {
                return ""
                
            }
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            print("numer of rows")
            print(MyTriedexperiences.count)
            
            return MyTriedexperiences.count
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            
            print("inside cell for row index path")
            let cell: MyTriedListTableViewCell = MyTriedListTableView.dequeueReusableCellWithIdentifier("MyTriedcell") as! MyTriedListTableViewCell
            
            let Mywish = MyTriedexperiences[indexPath.row]
            
            cell.deleteExpbtn.tag = indexPath.row
            cell.deleteExpbtn.addTarget(self, action: "DeletebtnAction:", forControlEvents: .TouchUpInside)
            
            print("Mywish")
            
            print(Mywish.MyWishexperienceImage)
            
            cell.setCell(Mywish.MyWishexperienceImage, title: Mywish.MyWishexperienceTitle, expDate: Mywish.MyWishexperienceDate, exploc: Mywish.MyWishExperienceLocation)
            
            return cell
        }
    
    @IBAction func DeletebtnAction(sender:UIButton!) {
        
        sender.alpha = 0.2
        
        let user:PFUser = PFUser.currentUser()!
        let MyWishid = MyTriedexperiences[sender.tag].MyWishexperienceObjectID
        
        //the below one also works
        user.removeObjectsInArray([MyWishid], forKey: "triedExplist")
        user.saveEventually()
        self.MyTriedListTableView.reloadData()
       
    }
    
    
    @IBAction func backbtnPressed(sender: AnyObject) {
        
        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
                if segue.identifier == "TriedBack" {
                        let TriedBack = segue.destinationViewController as! ProfileViewController
                             TriedBack.triedCountpassed = String(MyTriedexperiences.count)
                    
                        }
            
                }
    }
    
}

