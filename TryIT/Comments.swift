//
//  Comments.swift
//  comments_try
//
//  Created by nivedita bhat on 10/22/15.
//  Copyright © 2015 nivedita bhat. All rights reserved.
//

import Foundation
import UIKit


class Comments {
    
    var CommentID : String
    var Comments : String
    var CommentsPostedID : String
    var CommentsPostedDate : NSDate
    var CommentsOnExp : String
    var CmtUserProfilePic : UIImage!
    
    
    init?(commentID: String, Comments: String,commentPostedId: String, PostedDate:NSDate,CmtsonExp:String,profilePic:UIImage) {
    
        self.CommentID = commentID
        self.Comments = Comments
        self.CommentsPostedID = commentPostedId
        self.CommentsPostedDate = PostedDate
        self.CommentsOnExp = CmtsonExp
        self.CmtUserProfilePic = profilePic
    }
}


