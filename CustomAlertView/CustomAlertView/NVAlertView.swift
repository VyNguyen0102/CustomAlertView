//
//  NVAlertView.swift
//  CustomAlertView
//
//  Created by VyNV on 12/25/15.
//  Copyright © 2015 Vy Nguyen. All rights reserved.
//

import UIKit

class NVAlertView: NSObject {
    
    var rootView:UIView
    var buttonTitle:NSString
    
    //var completion:() -> Void?
    
    var panelView:UIView?
    var alertBackground:UIView?
    var closeButton:UIButton?
    
    
    init(rootView:UIView, buttonTitle:NSString){
        self.rootView = rootView
        self.buttonTitle = buttonTitle
    }
    
    func showPopUp() {
        setupView()
    }
    
    func showPopUpWithCompletion(completion: () -> Void) {
        setupView()
        //        self.completion = { completion($0) }
    }
    
    func setupView() {
        self.panelView = NSBundle.mainBundle().loadNibNamed("NVAlertView", owner: self, options: nil)[0] as? UIView
        self.panelView?.translatesAutoresizingMaskIntoConstraints = false;
        self.alertBackground = self.panelView!.viewWithTag(0)!;
        self.alertBackground!.clipsToBounds = true;
        self.layoutToRootView()
    }
    
    func layoutToRootView() {
        UIView.transitionWithView(self.rootView, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            self.rootView.addSubview(self.panelView!)
            }, completion: nil)
        
        let top = NSLayoutConstraint(item: self.panelView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.rootView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let bottom = NSLayoutConstraint(item: self.panelView!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.rootView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let trailing = NSLayoutConstraint(item: self.panelView!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.rootView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let leading = NSLayoutConstraint(item: self.panelView!, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.rootView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        self.rootView.addConstraint(top)
        self.rootView.addConstraint(bottom)
        self.rootView.addConstraint(trailing)
        self.rootView.addConstraint(leading)
        NSLayoutConstraint.activateConstraints([bottom, trailing, top, leading])
    }
}
