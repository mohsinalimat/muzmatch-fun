//
//  ViewController.swift
//  muzmatch
//
//  Created by Nabil Freeman on 09/03/2016.
//  Copyright © 2016 Nabil Freeman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var bioTitle: UIView!
    
    @IBOutlet weak var bioHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nope: UIView!
    @IBOutlet weak var yep: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //add sexy blur effect to tabBar.
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            bioTitle.backgroundColor = UIColor.clearColor()
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = bioTitle.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            //insert this right at the bottom of our tabBar, z-index 0
            bioTitle.insertSubview(blurEffectView, atIndex: 0)
        }
        
        //let url = NSURL (string: "http://localhost");
        let url = NSBundle.mainBundle().URLForResource("bio", withExtension: "html")
        
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.Ended){
            
            var newConstant = 500;
            if(bioHeight.constant < 300){
                newConstant = 100;
            }
            
            self.bioHeight.constant = CGFloat(newConstant);
            UIView.animateWithDuration(0.2, delay: 0, options: .CurveLinear, animations: {
                self.bioView.layoutIfNeeded();
            }, completion: nil);
            
        } else {
            
            let translation = recognizer.translationInView(self.view)
            
            bioHeight.constant = bioHeight.constant - translation.y;
            
            if(bioHeight.constant > 500){
                bioHeight.constant = 500;
            }
            if(bioHeight.constant < 100){
                bioHeight.constant = 100;
            }
            
        }
        
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
}

