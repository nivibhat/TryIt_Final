//
//  ProfileTableViewCustomCell.swift
//  TryIt
//
//  Created by nivedita bhat on 11/7/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit

class ProfileTableViewCustomCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
 
  
    @IBOutlet weak var cmtText: UITextView!
  
    @IBOutlet weak var onExplbl: UILabel!
    
    @IBOutlet weak var DeleteCmtBtn: UIButton!
    
    @IBOutlet weak var cmtPostedDatelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(picture:UIImage, comments:String, posteddate:NSDate, OnExp:String) {
        
        print("inside setcell")
        print(comments)
        
       // print(commentsTextview.text!)
       
        if cmtText != nil {
            cmtText.text = comments
            
        }
        self.profilePic.image = picture
        self.onExplbl.text = OnExp
        self.cmtPostedDatelbl.text = String(posteddate)
    }
    
}
