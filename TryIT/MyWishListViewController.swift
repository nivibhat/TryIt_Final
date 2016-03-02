//
//  MyWishListViewController.swift
//  TryIt
//
//  Created by nivedita bhat on 11/25/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//
import Foundation
import UIKit
import Social
import Parse

class MyWishListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var MyWishListTableView: UITableView!
    var MyWishexperiences: [MyList] = [MyList]()

    var myWishListids:[String]! = []
    
    @IBOutlet weak var myWishexistancelbl: UILabel!
    
    func codeToExecuteBeforeStringsAreAppended() {
    }
    func codeToExecuteAfterStringsAreAppended() {
        // can use the array 'userData'
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "notificationResponse:",
            name: "recordsLoaded",
            object: nil
        )
        
        self.MyWishListTableView.delegate = self;
        self.MyWishListTableView.dataSource = self;

        MyWishListTableView.separatorStyle = .None
        
         codeToExecuteBeforeStringsAreAppended()
        setupMyWishList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func setupMyWishList() {
      let notification = NSNotification(name: "userDataRetrieved", object: self)
        myWishListids = PFUser.currentUser()!.objectForKey("myWishList")as? Array<String>
        var i = 0
        if (myWishListids != nil) {
            self.myWishexistancelbl.text = "You have liked the below experiences!"
            while (i < myWishListids.count)
            {
                   // print("Printing current user")
           // print(myWishListids[i])
            
            let query = PFQuery(className: "ExperienceList")
            query.whereKey("objectId", equalTo: myWishListids[i])
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
                                    
                                    
                                    let Exptitle = exp["ExpTitle"]
                                    print(Exptitle)
                                    let date = exp["StartDate"]as! NSDate //get the time, in this case the time an object was created.
                                    
                                    //format date
                                    let dateFormatter = NSDateFormatter()
                                    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
                                    dateFormatter.dateFormat = "MM'-'dd HH':'mm" //format style. Browse online to get a format that fits your needs.
                                    let dateString = dateFormatter.stringFromDate(date)
                                    let explocation = exp["Location"]
                                    print(explocation)
                                    
                                    let MyWishList = MyList(experienceObjectID: exp.objectId!, experienceTitle: Exptitle as! String, experienceImage: expImage, experienceDate: dateString, location: explocation as! String)
                                    
                                    self.MyWishexperiences.append(MyWishList!)
                                    
                                    print(self.MyWishexperiences.count)
                                    self.MyWishListTableView.reloadData()

                               
                                }
                            }
                            
//                                let Exptitle = exp["ExpTitle"]
//                            print(Exptitle)
//                                let date = exp["StartDate"]as! NSDate //get the time, in this case the time an object was created.
//                                
//                                //format date
//                                let dateFormatter = NSDateFormatter()
//                                dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
//                                dateFormatter.dateFormat = "MM'-'dd HH':'mm" //format style. Browse online to get a format that fits your needs.
//                                let dateString = dateFormatter.stringFromDate(date)
//                                let explocation = exp["Location"]
//                                print(explocation)
//
//                                let MyWishList = MyList(experienceObjectID: exp.objectId!, experienceTitle: Exptitle as! String, experienceImage: expImage, experienceDate: dateString, location: explocation as! String)
//                                
//                                self.MyWishexperiences.append(MyWishList!)
//   
//                            print(self.MyWishexperiences.count)
//                            self.MyWishListTableView.reloadData()
                        }
                   }
                  NSNotificationCenter.defaultCenter().postNotification(notification)
              }
            
              i = i + 1
            }
        } else {
            self.myWishexistancelbl.text = "Don't have anything? It's time to choose some experience!"
        }
    }
    
    func notificationResponse (notification: NSNotification) {
        
        
        // this is executed after the background processing is done
        // Insert the code that uses the data retrieved from Parse
        codeToExecuteAfterStringsAreAppended()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("numer of rows")
        print(MyWishexperiences.count)
        return MyWishexperiences.count        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
  
        print("inside cell for row index path")
        let cell: MyWishListTableViewCell = MyWishListTableView.dequeueReusableCellWithIdentifier("WishCell") as! MyWishListTableViewCell
        
        cell.MyWishGoingbtn.tag = indexPath.row
        cell.MyWishGoingbtn.addTarget(self, action: "GoingbtnAction:", forControlEvents: .TouchUpInside)
        
        let Mywish = MyWishexperiences[indexPath.row]
        print("Mywish")
        
        print(Mywish.MyWishexperienceImage)
                
        
        cell.setCell(Mywish.MyWishexperienceImage, title: Mywish.MyWishexperienceTitle, expDate: Mywish.MyWishexperienceDate, exploc: Mywish.MyWishExperienceLocation)
 
        return cell
    }
        
    @IBAction func GoingbtnAction(sender: UIButton!) {
        
        sender.alpha = 0.2
        
        //save the experienceid and into user class
        
        let user:PFUser = PFUser.currentUser()!
        let MyWishid = MyWishexperiences[sender.tag].MyWishexperienceObjectID
   
        //the below one also works
        user.addUniqueObjectsFromArray([MyWishid], forKey: "triedExplist")
        user.saveInBackground()
        user.removeObjectsInArray([MyWishid], forKey: "myWishList")
        user.saveEventually()
        self.MyWishListTableView.reloadData()
    }
    
}

