//
//  TwitterTweets.swift


import UIKit

struct TwitterTweet {
    var name: String?
    var tweet: String?
    var profileImage : String?

    
    init (name: String, tweet: String, profileImage : String) {
        
        self.name = name
        self.tweet = tweet
        self.profileImage = profileImage

        
    }
}