//
//  WebViewViewController.swift
//  TryIT
//
//  Created by macbook_user on 12/7/15.
//  Copyright © 2015 TryIt. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    var experienceID:String = ""
    
    var urlString : String = ""
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL (string: urlString);
        let requestObj = NSURLRequest(URL: url!);
         webView.loadRequest(requestObj);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "webViewToExpDetail" {
            
            let destViewController = segue.destinationViewController as! ExperienceDetailViewController
            
            destViewController.ExperienceObjectID = self.experienceID
            
            //destViewController.urlString = (self.ExpURL.titleLabel?.text)!
            
        }
    }
   
    

}
