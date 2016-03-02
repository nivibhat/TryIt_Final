//
//  ExpCommentsTableViewCell.swift
//  TryIt
//
//  Created by nivedita bhat on 12/3/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Parse
import Social


class ExpCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var profilepicCmt: UIImageView!
    
    @IBOutlet weak var Comments: UITextView!
    
    
    
    func setCell(picture:UIImage, comments:String) {
        
        print("inside setcell")
        print(comments)
        
        // print(commentsTextview.text!)
        
        if Comments != nil {
            Comments.text = comments
            
        }
        self.profilepicCmt.image = picture
        
        
    }
    
}
