//
//  ExperienceTableViewCell.swift
//  TryIt
//
//  Created by Jingwei Ji on 10/15/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit
import Parse
import Social


class ExperienceTableViewCell: UITableViewCell {

    
    var parseObject:PFObject?
    @IBOutlet weak var bkImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLikeslbl: UILabel!
   
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var commentCount: UILabel!
    
    @IBOutlet weak var unlikeBtn: UIButton!
    
    @IBOutlet weak var commentExpBtn: UIButton!
    
    override func awakeFromNib() {
        let gesture = UITapGestureRecognizer(target: self, action:Selector("onDoubleTap:"))
        gesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gesture)
    
        
        
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func onDoubleTap(sender:AnyObject) {
        
        bkImageView.alpha = 0.5
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
