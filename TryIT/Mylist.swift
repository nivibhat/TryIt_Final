//
//  Mylist.swift
//  TryIt
//
//  Created by nivedita bhat on 11/29/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import Foundation
import UIKit


class MyList {
    
    var MyWishexperienceObjectID: String
    var MyWishexperienceTitle: String
    var MyWishexperienceImage: UIImage
    var MyWishexperienceDate: String

    var MyWishExperienceLocation :String
    
    
    init?(experienceObjectID: String, experienceTitle: String, experienceImage:UIImage, experienceDate: String, location:String)
    {
        self.MyWishexperienceObjectID = experienceObjectID
        self.MyWishexperienceTitle = experienceTitle
        self.MyWishexperienceImage = experienceImage
        self.MyWishexperienceDate = experienceDate

        self.MyWishExperienceLocation = location
        
        if experienceTitle.isEmpty {
            return nil
        }
        
    }
    

}
