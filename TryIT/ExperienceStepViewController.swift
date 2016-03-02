//
//  ExperienceSteplViewController.swift
//  TryIt
//
//  Created by Jingwei Ji on 10/17/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit

class ExperienceStepViewController: UIViewController {

    @IBOutlet private weak var backgroundImageView: UIImageView!


  var backgroundImage: UIImage?


  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    //backgroundImage = scaleUIImageToSize(backgroundImage!, size: CGSize(width: 600,height: 300))
    
    backgroundImageView.image = backgroundImage

  }
    
    
        
    
}

