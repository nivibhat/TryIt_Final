//
//  LaunchscreenViewController.swift
//  TryIT
//
//  Created by macbook_user on 12/4/15.
//  Copyright © 2015 TryIt. All rights reserved.
//

import UIKit

class LaunchscreenViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    // must be internal or public.
    func update() {
        performSegueWithIdentifier("launchfinish", sender: self)
    }


}
