
//
//  NVAlertView.swift
//  CustomAlertView
//
//  Created by VyNV on 12/25/15.
//  Copyright © 2015 Vy Nguyen. All rights reserved.
//

import UIKit

enum AlertViewResult {
    case OK, Cancel, Unknown
}

class NVAlertView: NSObject {
    
    let nibName = "NVAlertView"
    let popupConerRadius:CGFloat = 5.0
    
    var rootView:UIView
    var buttonTitle:NSString
    var completion:(AlertViewResult) -> Void = { (arg:AlertViewResult) -> Void in
    }
    
    // Layout
    var alertRootView:UIView?
    var alertBackground:UIView?
    var alertPanel:UIView?
    var closeButton:UIButton?
    
    // Release retain
    var retainedSelves:NSMutableArray?
    
    init(rootView:UIView, buttonTitle:NSString){
        self.rootView = rootView
        self.buttonTitle = buttonTitle
        retainedSelves = NSMutableArray()
    }
    
    func showPopUp() {
        setupView()
    }
    
    func showPopUpWithCompletion(completion: (arg:AlertViewResult) -> Void) {
        self.completion = completion
        setupView()
    }
    
    func setupView() {
        self.alertRootView = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil)[0] as? UIView
        self.alertRootView?.translatesAutoresizingMaskIntoConstraints = false;
        self.alertBackground = self.alertRootView!.viewWithTag(0)!;
        self.alertPanel = self.alertRootView!.viewWithTag(1)!;
        self.closeButton = self.alertRootView!.viewWithTag(2) as? UIButton;
        self.closeButton?.addTarget(self, action: Selector("closeAlertDialog:"), forControlEvents: .TouchUpInside)
        self.alertBackground!.clipsToBounds = true;
        
        // Layout to root view
        self.layoutToRootView()
        self.retainSelf()
        self.customLayout()
    }
    
    func customLayout() {
        let layerPopup = self.alertPanel!.layer
        layerPopup.cornerRadius = popupConerRadius
        layerPopup.masksToBounds = true
    }
    
    func layoutToRootView() {
        UIView.transitionWithView(self.rootView, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            self.rootView.addSubview(self.alertRootView!)
            }, completion: nil)
        
        let top = NSLayoutConstraint(item: self.alertRootView!,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.rootView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0, constant: 0)
        
        let bottom = NSLayoutConstraint(item: self.alertRootView!,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.rootView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0, constant: 0)
        
        let trailing = NSLayoutConstraint(item: self.alertRootView!,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.rootView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0, constant: 0)
        
        let leading = NSLayoutConstraint(item: self.alertRootView!,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.rootView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0, constant: 0)
        
        self.rootView.addConstraint(top)
        self.rootView.addConstraint(bottom)
        self.rootView.addConstraint(trailing)
        self.rootView.addConstraint(leading)
        NSLayoutConstraint.activateConstraints([bottom, trailing, top, leading])
    }
    
    func closeAlertDialog(sender: UIButton) {
        self.alertRootView?.removeFromSuperview()
        completion(AlertViewResult.OK)
        self.releaseSelf()
    }
    func retainSelf() {
        self.retainedSelves!.addObject(self)
    }
    func releaseSelf() {
        self.retainedSelves!.removeLastObject()
    }
}
