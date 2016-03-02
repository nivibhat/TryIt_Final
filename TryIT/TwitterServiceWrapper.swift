//
//  Authenticator.swift


import UIKit

protocol TwitterTweetDelegate{
    func finishedDownloading(tweetText:TwitterTweet)
}

public class TwitterServiceWrapper:NSObject {
    
    var delegate:TwitterTweetDelegate?
    let consumerKey = "ykwEk5EI4elNTi0f2O0FzKLLc"
    let consumerSecret = "O842OmDhoprtWeVuKRMJbKtbJyutdcaIuXkghuFLJKeeZwjE9a"
    let authURL = "https://api.twitter.com/oauth2/token"

    // MARK:- Bearer Token
    
    func getBearerToken(completion:(bearerToken: String) ->Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: authURL)!)
        
        request.HTTPMethod = "POST"
        request.addValue("Basic " + getBase64EncodeString(), forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let grantType =  "grant_type=client_credentials"
        
        request.HTTPBody = grantType.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLSession.sharedSession() .dataTaskWithRequest(request, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
            
            do {
                if let results: NSDictionary = try NSJSONSerialization .JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments  ) as? NSDictionary {
                    if let token = results["access_token"] as? String {
                        completion(bearerToken: token)
                    } else {
                        print(results["errors"])
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }).resume()
        
    }
    
    // MARK:- base64Encode String
    
    func getBase64EncodeString() -> String {
        
        let consumerKeyRFC1738 = consumerKey.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        let consumerSecretRFC1738 = consumerSecret.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())        
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        
        let secretAndKeyData = concatenateKeyAndSecret.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        
        let base64EncodeKeyAndSecret = secretAndKeyData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        
        return base64EncodeKeyAndSecret!
    }
    
    // MARK:- Service Call
    
    func getResponseForRequest(url:String) {
        
        getBearerToken({ (bearerToken) -> Void in
            
            let request = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = "GET"
            
            let token = "Bearer " + bearerToken
            
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            NSURLSession.sharedSession() .dataTaskWithRequest(request, completionHandler: { (data: NSData?, response:NSURLResponse?, error: NSError?) -> Void in
                
                self.processResult(data!, response: response!, error: error)
                
            }).resume()
        })
        
    }
    
    // MARK:- Process results
    
    func processResult(data: NSData, response:NSURLResponse, error: NSError?) {
        
        do {
            
            if let results: NSDictionary = try NSJSONSerialization .JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments  ) as? NSDictionary {
                

                if let statuses = results["statuses"] as? NSMutableArray {
                    for status in statuses {
                        let user = status["user"] as! NSDictionary
                        //let imageURL = user["profile_image_url"] as! String
                        

                        
                        let tweetText = TwitterTweet(name: user["name"] as! String, tweet: status["text"] as! String,
                            profileImage: user["profile_image_url"] as! String)
                        
                        self.delegate?.finishedDownloading(tweetText)
                    }
                    
                } else {
                    print(results["errors"])
                }
                
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}