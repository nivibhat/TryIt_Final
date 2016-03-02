//
//  ExperienceDetailViewController.swift
//  tryIt
//
//  Created by Akshay on 10/12/15.
//  Copyright © 2015 Akshay. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class ExperienceDetailViewController: UIViewController {
    
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    var expImage0:UIImage!
    var expImage1:UIImage!
    var expImage2:UIImage!
    var expImage3:UIImage!
    var expImage4:UIImage!

    
    
    var imageNumber:Int = 0;
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var ExperienceObjectID: String = String()
    
    @IBOutlet weak var ExpTitle: UILabel!
    
    @IBOutlet weak var ExpImage: UIImageView!
    
    @IBOutlet weak var ExpCategory: UILabel!
    
    @IBOutlet weak var ExpStartToEndDate: UILabel!
    
    @IBOutlet weak var ExpDescription: UITextView!
    
    @IBOutlet weak var ExpPrice: UILabel!
    
    @IBOutlet weak var ExpURL: UIButton!
    
    @IBOutlet weak var ExpMap: MKMapView!
    
   // var experienceInfo : ExperienceModel!
    var experienceObject : PFObject!
    var experienceId: String = ""
    var expobjectid : PFObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respond1:")
        swipeRight.direction = .Right
        
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respond2:")
        swipeLeft.direction = .Left
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        
       // ExpImage.addGestureRecognizer(swipeLeft)
        
        
        
        ExpDescription.editable = false
        scrollView.contentSize.height = 800
        
        var query = PFQuery(className:"ExperienceList")
        
        
        query.getObjectInBackgroundWithId(ExperienceObjectID) {
            (experience: PFObject?, error: NSError?) -> Void in
            if error == nil && experience != nil {
                
                
                let expImageFile0 = experience!["PrimaryPic"]as! PFFile
                let expImageFile1 = experience!["Image1"] as! PFFile
                let expImageFile2 = experience!["Image2"] as! PFFile
                let expImageFile3 = experience!["Image3"] as! PFFile
                let expImageFile4 = experience!["Image4"] as! PFFile
                
                
                
                expImageFile0.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    
                    
                    
                    if error == nil && imageData != nil {
                        self.expImage0  = UIImage(data:imageData!)!
                        
                        self.ExpImage.image = self.expImage0
                        
                        
                        
                        // do something with image here
                    }
                }
                
                expImageFile1.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    
                    
                    
                    if error == nil && imageData != nil {
//                        self.expImage0  = UIImage(data:imageData!)!
//                        
//                        self.ExpImage.image = self.expImage0
//                        
                        self.expImage1  = UIImage(data:imageData!)!
                        
                        // do something with image here
                    }
                }
                
                expImageFile2.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    
                    
                    
                    if error == nil && imageData != nil {
//                        self.expImage0  = UIImage(data:imageData!)!
//                        
//                        self.ExpImage.image = self.expImage0
//                        
//                        
                        self.expImage2  = UIImage(data:imageData!)!
                        
                        // do something with image here
                    }
                }
                
                expImageFile3.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    
                    
                    
                    if error == nil && imageData != nil {
//                        self.expImage0  = UIImage(data:imageData!)!
//                        
//                        self.ExpImage.image = self.expImage0
//                        
                        self.expImage3  = UIImage(data:imageData!)!
                        
                        
                        // do something with image here
                    }
                }
                
                expImageFile4.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    
                    
                    
                    if error == nil && imageData != nil {
//                        self.expImage0  = UIImage(data:imageData!)!
//                        
//                        self.ExpImage.image = self.expImage0
//                        
                        self.expImage4  = UIImage(data:imageData!)!
                        
                        // do something with image here
                    }
                }
                
                
                
                let expTitle = experience!["ExpTitle"]as! String
                
                self.ExpTitle.text = expTitle
                
                let startDate = experience!["StartDate"]as! NSDate //get the time, in this case the time an object was created.
                //format date
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "mm/dd/yyyy" //format style. Browse online to get a format that fits your needs.
                let startDateString = dateFormatter.stringFromDate(startDate)
               
                
                let endDate = experience!["EndDate"]as! NSDate //get the time, in this case the time an object was created.
                //format date
                
                dateFormatter.dateFormat = "mm/dd/yyyy" //format style. Browse online to get a format that fits your needs.
                let endDateString = dateFormatter.stringFromDate(endDate)
              
                let date = startDateString + " TO " + endDateString
                
                self.ExpStartToEndDate.text = date
                
                
                let category = experience!["ExpCategory"]as! String
                self.ExpCategory.text = category
                
                let price = experience!["Price"]as! NSNumber
                
                self.ExpPrice.text = "Price: $"+price.stringValue
                
                let url = experience!["Url"]as! String
                self.ExpURL.setTitle(url, forState: UIControlState.Normal )
                
                let description = experience!["Description"]as! String
                self.ExpDescription.text = description
                
                
                let geoLocation = experience!["GeoLocation"] as! PFGeoPoint
                let latitude = geoLocation.latitude
                let longitude = geoLocation.longitude
                let location = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpanMake(0.02, 0.02)
                let region = MKCoordinateRegion(center: location, span: span)
                self.ExpMap.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate  = location
                
                annotation.title = expTitle
                annotation.subtitle = description
                self.ExpMap.addAnnotation(annotation)
                
                
                
            } else {
                print(error)
            }
        }
       
        
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func urlButtonAction(sender: AnyObject) {
        
        if(!ExpURL.titleLabel!.text!.isEqual("N/A")){
        
        performSegueWithIdentifier("urlToWebView", sender: self)
        
        }
        else{
        }
    }
    
    
    
    
    
    @IBAction func decideToGoClicked(sender: UIButton) {
        
        sender.setTitle("☑︎Yes,I am going", forState: .Normal)
        sender.alpha = 0.2
        
        //save the experienceid and into user class
        
        let user:PFUser = PFUser.currentUser()!
        
        //the below one also works
        user.addUniqueObjectsFromArray([experienceId], forKey: "triedExplist")
        user.saveInBackground()
        
      //  let shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    //    shareToTwitter.setInitialText("#tryitapp #\(removeSpace(experienceInfo.experienceTitle)) ")
        
   //     self.presentViewController(shareToTwitter, animated: true, completion: nil)
    }

    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "urlToWebView" {
        
            let destViewController = segue.destinationViewController as! WebViewViewController
        
            destViewController.experienceID = self.ExperienceObjectID
            
            destViewController.urlString = (self.ExpURL.titleLabel?.text)!
            
        }
    }
    
    
    func imageToPut(){
        if(imageNumber == 0){
            ExpImage.image = expImage0
        }
        else if(imageNumber == 1){
            ExpImage.image = expImage1
        }
        else if(imageNumber == 2){
            ExpImage.image = expImage2
        }
        else if(imageNumber == 3){
            ExpImage.image = expImage3
        }
        else if(imageNumber == 4){
            ExpImage.image = expImage4
        }
        
        
    
    }
    
    
    
    func respond1(gesture: UIGestureRecognizer){
        swipeRight()
        print("\n\n\n\n\n\n\n\n\n\n\nSwipedRight")
    
    }
    
    func respond2(gesture: UIGestureRecognizer){
        swipeLeft()
        print("\n\n\n\n\n\n\n\n\n\n\nSwipedLeft")
        
    }
    
    
    
    
    func swipeRight(){
        if(imageNumber == 4){
            imageNumber = 0}
        else{
            imageNumber = imageNumber + 1
        }
        imageToPut()
        
    }
    
    func swipeLeft(){
        if(imageNumber == 0){
            imageNumber = 4}
        else{
            imageNumber = imageNumber - 1
        }
        imageToPut()
        
    }
    

}
