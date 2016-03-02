//
//  ExperienceModel.swift
//  TryIt
//
//  Created by Jingwei Ji on 10/14/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit

class ExperienceModel {

    var experienceObjectID: String
    var experienceTitle: String
    var experienceImage: UIImage
    var experienceDate: String
    var category : String
    
    init?(experienceObjectID: String, experienceTitle: String, experienceImage:UIImage, experienceDate: String, category: String)
    {
        self.experienceObjectID = experienceObjectID
        self.experienceTitle = experienceTitle
        self.experienceImage = experienceImage
        self.experienceDate = experienceDate
        self.category = category
        
        if experienceTitle.isEmpty {
            return nil
        }
        
    }

        
    
}