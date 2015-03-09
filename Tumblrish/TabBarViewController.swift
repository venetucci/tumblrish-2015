//
//  TabBarViewController.swift
//  Tumblrish
//
//  Created by Michelle Venetucci Harvey on 3/6/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController  {

    var isPresenting: Bool = true
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var exploreBobblePopup: UIImageView!
    
    @IBOutlet weak var composeViewContainer: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    var viewControllersArray: [UIViewController]! = [UIViewController]()
    var selectedIndex: Int! = 0
    var duration: NSTimeInterval!
    var homeViewController: UIViewController!
    var searchViewController: UIViewController!
    var accountViewController: UIViewController!
    var trendingViewController: UIViewController!
    var composeViewController: UIViewController!
    
    var composeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("homeViewStory") as UIViewController
        searchViewController = storyboard.instantiateViewControllerWithIdentifier("searchViewStory") as UIViewController
        accountViewController = storyboard.instantiateViewControllerWithIdentifier("accountViewStory") as UIViewController
        trendingViewController = storyboard.instantiateViewControllerWithIdentifier("trendingViewStory") as UIViewController
        composeViewController = storyboard.instantiateViewControllerWithIdentifier("composeViewStory") as ComposeViewController
        
        viewControllersArray = [homeViewController, searchViewController, accountViewController, trendingViewController]
        
        tabBarDidPress(buttons[0])
        
        exploreBobbleAnimate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func displayContentController(content: UIViewController) {
        addChildViewController(content)
        contentView.addSubview(content.view)
        content.didMoveToParentViewController(self)
    }
    

    func hideContentController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    @IBAction func tabBarDidPress(sender: AnyObject) {
        
        removeChildView(viewControllersArray[selectedIndex])
        buttons[selectedIndex].selected = false
        
        selectedIndex = sender.tag
        
        buttons[selectedIndex].selected = true
        addChildViewController(viewControllersArray[selectedIndex])
        var tabContentView = viewControllersArray[selectedIndex].view
        tabContentView.frame = contentView.frame
        contentView.addSubview(tabContentView)
        viewControllersArray[selectedIndex].didMoveToParentViewController(self)
        
        exploreBobblePopup.hidden = (selectedIndex==1)
    }
    
    func removeChildView(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    @IBAction func didPressComposeButton(sender: AnyObject) {
        performSegueWithIdentifier("composeSegue", sender: self)
    }

    func exploreBobbleAnimate()
    {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations:
            { () -> Void in
                self.exploreBobblePopup.center.y = 490
            })
            { (finished: Bool) -> Void in
                
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                    { () -> Void in
                        self.exploreBobblePopup.center.y = 495
                    })
                    { (Bool) -> Void in
                    }
            }
    }
}