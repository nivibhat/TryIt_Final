//
//  SocialCustomTableViewCell.swift
//  TryIT
//
//  Created by nivedita bhat on 12/7/15.
//  Copyright © 2015 TryIt. All rights reserved.
//

import UIKit


class SocialCustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var socialProfilePic: UIImageView!

    @IBOutlet weak var SocialComments: UITextView!
    
    @IBOutlet weak var SocialCmtDate: UILabel!
    
    @IBOutlet weak var SocialCmtOnExp: UILabel!
    
    
    
    func setCell(picture:UIImage, comments:String, posteddate:NSDate, OnExp:String) {
        
        print("inside setcell")
        print(comments)
        
        // print(commentsTextview.text!)
        
        if SocialComments != nil {
            SocialComments.text = comments
            
        }
        self.socialProfilePic.image = picture
        self.SocialCmtOnExp.text = OnExp
        self.SocialCmtDate.text = String(posteddate)
    }
    
}
