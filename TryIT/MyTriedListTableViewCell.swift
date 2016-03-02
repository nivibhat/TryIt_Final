//
//  MyTriedListTableViewCell.swift
//  TryIt
//
//  Created by nivedita bhat on 11/30/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit

class MyTriedListTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var MyTriedImage: UIImageView!
    
    @IBOutlet weak var TriedExpLocation: UILabel!
    
    @IBOutlet weak var TriedExpTitle: UILabel!
    
    
    @IBOutlet weak var TriedExpDate: UILabel!
    
    @IBOutlet weak var deleteExpbtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(picture:UIImage,title:String,expDate:String,exploc:String) {
        
        // print(commentsTextview.text!)
        
        print("image is")
        print(picture)
        self.MyTriedImage.image = picture
        self.TriedExpTitle.text = title
        self.TriedExpDate.text = expDate
        self.TriedExpLocation.text = exploc
        
    }
    
    
    @IBAction func triedexpBtnPressed(sender: AnyObject) {
    }
}
