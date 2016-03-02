//
//  TwitterTweetController.swift


import UIKit

class TwitterTweetViewController: UITableViewController, TwitterTweetDelegate {
    
    var experienceTitle: String!
    var serviceWrapper: TwitterServiceWrapper = TwitterServiceWrapper()
    var tweetText = [TwitterTweet]()
    
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceWrapper.delegate = self
        
        //activityIndicator.startAnimating()
        
        serviceWrapper.getResponseForRequest("https://api.twitter.com/1.1/search/tweets.json?q=%23tryitapp+%23\(experienceTitle)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetText.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) 
        cell.detailTextLabel!.numberOfLines = 0
        let twitterTweet = tweetText[indexPath.row] as TwitterTweet
        cell.textLabel?.text = twitterTweet.name!
        cell.detailTextLabel?.text = twitterTweet.tweet!
        
        let imageURL = NSURL(string: twitterTweet.profileImage!)!
        let image = UIImage(data:  NSData(contentsOfURL: imageURL)!)
        cell.imageView?.image = image
        
        
        return cell
        
        
    }
    

    
    
    // MARK: - TwitterTweetDelegate methods
    
    func finishedDownloading(tweetText: TwitterTweet) {
       dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tweetText.append(tweetText)
            self.tableView.reloadData()
            //self.activityIndicator.stopAnimating()
            //self.activityIndicator.hidden = true
        })
    }
    
}
