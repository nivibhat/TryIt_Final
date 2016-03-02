//
//  userPreferrence.swift
//  TryIt
//
//  Created by Jingwei Ji on 11/9/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import Foundation

class userPreferrence :NSObject, NSCoding {
    var userInterestedInCategories: [String]
    
    override init(){
        if let saveduserInterestedInCategories = userPreferrence.loadSaved(){
            self.userInterestedInCategories = saveduserInterestedInCategories.userInterestedInCategories
        }
        else{
            self.userInterestedInCategories = ["All"]
        }
    }
    
    required init(coder aDecoder: NSCoder){
        self.userInterestedInCategories = aDecoder.decodeObjectForKey("userInterestedInCategories") as! [String]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.userInterestedInCategories, forKey: "userInterestedInCategories")
    }
    
    func save(){
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "userInterestedInCategoriesData")
    }
    
    class func loadSaved() -> userPreferrence? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("userInterestedInCategoriesData") as? NSData{
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? userPreferrence
        }
        return nil
    }
    
    
}
