//
//  MyWishListTableViewCell.swift
//  TryIt
//
//  Created by nivedita bhat on 11/25/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit

class MyWishListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var MyWishImage: UIImageView!
    
    @IBOutlet weak var wishExpTitle: UILabel!
    
    @IBOutlet weak var WishExpLocation: UILabel!
    @IBOutlet weak var WishExpDate: UILabel!
    
    
    @IBOutlet weak var MyWishGoingbtn: UIButton!
    
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
       // print(picture)
             MyWishImage.contentMode = .ScaleAspectFit
        self.MyWishImage.image = picture
   print(self.MyWishImage)
        print("image rendered ")
        self.wishExpTitle.text = title
        self.WishExpDate.text = expDate
        self.WishExpLocation.text = exploc
    
    }
    
    @IBAction func GoingBtnPressed(sender: AnyObject) {
        
        
    }

}
