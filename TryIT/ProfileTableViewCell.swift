//
//  ProfileTableViewCell.swift
//  TryIt
//
//  Created by nivedita bhat on 10/31/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//


import UIKit


class ProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileComments: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(profilepic:UIImage,commentId:String,UserId:String, comments:String) {
    
        self.profilePic.image = profilepic
        self.profileComments.text = comments
        
    }

}
