//
//  UIView+Gestures.swift
//  MeatStore
//
//  Created by prog_zidane on 6/29/20.
//  Copyright © 2020 Zidane. All rights reserved.
//


import Foundation
import UIKit

 extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var gestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    fileprivate typealias Action = (() -> Void)?
    // Set our computed property type to a closure
    fileprivate var gestureRecognizerAction: Action? {
        set{
             if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.gestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
             }
        }
        get {
            let gestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.gestureRecognizer) as? Action
            return gestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.gestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleGestureAction))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleGestureAction(sender: UITapGestureRecognizer) {
        if let action = self.gestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    public func addSwipGestureRecognizer(direction:UISwipeGestureRecognizer.Direction,action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.gestureRecognizerAction = action
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureAction))
        swipeGesture.direction = direction
        self.addGestureRecognizer(swipeGesture)
    }
    
    public func addPanGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.gestureRecognizerAction = action
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGestureAction))
        self.addGestureRecognizer(panGesture)
    }
    
    public func createBlurView(style: UIBlurEffect.Style) -> UIVisualEffectView
    {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        return blurEffectView
    }
    
    public func addBlurToView(style: UIBlurEffect.Style)
    {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    public func removeBlur() {
        subviews.forEach { subView in
            if subView is UIVisualEffectView {
                subView.removeFromSuperview()
            }
        }
    }
}
