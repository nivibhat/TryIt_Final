//
//  containerViewController.swift
//  TryIt
//
//  Created by Jingwei Ji on 11/8/15.
//  Copyright © 2015 the University of Iowa. All rights reserved.
//

import UIKit

protocol containerDelegate {
    func categoryIsSelected(category: String)
}

class containerViewController: UIViewController, ExperienceListViewControllerDelegate {
    var scrollingView : UIView!
    var userPreferrenceModel : userPreferrence!
    //let categorys = ["All", "Film","Sports", "Music","Seasonal", "Politics", "Dance", "Speeches"]
    var categorys : [String]!
    let padding = CGSizeMake(50.0, 0.0)
    let buttonSize = CGSizeMake(80.0,50.0)
    var delegate : containerDelegate!
    var previousButton : UIButton!
    
    @IBOutlet weak var categoryScorllView: UIScrollView!
    
    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPreferrenceModel = userPreferrence()
        categorys = userPreferrenceModel.userInterestedInCategories
        /*
        scrollingView = colorButtonsView(buttonSize, padding: padding, buttonCount: categorys.count)
        categoryScorllView.contentSize = scrollingView.frame.size

        categoryScorllView.addSubview(scrollingView)
        categoryScorllView.showsHorizontalScrollIndicator = false
        */
        

        // Do any additional setup after loading the view.
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func colorButtonsView(buttonSize:CGSize, padding : CGSize, buttonCount:Int) -> UIView {
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.lightGrayColor()
        buttonView.frame.origin = CGPointMake(0,0)

        buttonView.frame.size.width = (buttonSize.width + padding.width ) * CGFloat(buttonCount)
        
        buttonView.frame.size.height = (buttonSize.height +  2.0 * padding.height)
        //print(buttonView.frame.size.height)

        //add buttons to the view
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)

        for i in 0...(buttonCount - 1)  {
            let button = UIButton(type: .System) as UIButton
            button.frame.size = buttonSize
            buttonPosition.x = padding.width * 0.5 + (padding.width + buttonSize.width) * CGFloat(i)
            button.frame.origin = buttonPosition

            buttonView.frame.size.width = buttonPosition.x + (buttonSize.width + padding.width * 0.5)
            button.setTitle(categorys![i], forState: .Normal)
            button.backgroundColor = UIColor.lightGrayColor()
            button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            //if the view first loaded, change the color of the first button
            if i == 0 {
                previousButton = button
                previousButton.titleLabel!.font = UIFont.systemFontOfSize(18)
                previousButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
            
            buttonView.addSubview(button)
        }

        return buttonView
    }
    
    func buttonPressed(sender:UIButton){
        
        
        //UI changes a little so that user know they are touching something
        sender.titleLabel!.font = UIFont.systemFontOfSize(18)
        sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //remove previously clicked button UI effect
        previousButton.titleLabel!.font = UIFont.systemFontOfSize(15)
        previousButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        
        //inform experience list table view controller to render the list
        delegate.categoryIsSelected(sender.titleLabel!.text!)
        previousButton = sender
    }
    
    func experienceDownloadFinished(){
        userPreferrenceModel = userPreferrence()
        categorys = userPreferrenceModel.userInterestedInCategories
        scrollingView = colorButtonsView(buttonSize, padding: padding, buttonCount: categorys.count)
        categoryScorllView.contentSize = scrollingView.frame.size
        
        categoryScorllView.addSubview(scrollingView)
        categoryScorllView.showsHorizontalScrollIndicator = false
    }

}
