//
//  LoaderView.swift
//  Rakeb user
//
//  Created by prog_zidane on 12/28/20.
//  Copyright © 2020 Alamat. All rights reserved.
//
import Foundation
import UIKit
import NVActivityIndicatorView

public class LoadingView {
    
    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    static var currentLoadingText: String?
    
    static public func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow)
    }
    
    static public func show(_ loadingText: String) {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow, loadingText: loadingText)
    }
    
    static public func show(_ overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    static public func show(_ overlayTarget : UIView = UIApplication.getTopViewController()!.view!, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
    
        // Create the overlay
        let overlay = UIView()
        overlay.alpha = 0
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        overlay.topEqualTo(constraint: overlayTarget.topAnchor)
        overlay.bottomEqualTo(constraint: overlayTarget.bottomAnchor)

        overlay.backgroundColor = .black
        let loaderView = DesignableView()
        loaderView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loaderView.cornerRadius = 10
        
        //loaderView.backgroundColor = .white
        //loaderView.drobShadow = true
        let activity = NVActivityIndicatorView(frame: CGRect(x: 0 , y:0,width: 50, height: 50),type: .ballClipRotatePulse,color: Colors.activityColor.color,padding: 0.0)
        activity.center = loaderView.center
        loaderView.center = overlay.center
        loaderView.shadowColor = Colors.primary.color
        loaderView.addSubview(activity)
        overlay.addSubview(loaderView)
        loaderView.centerXequalTo(constraint: overlay.centerXAnchor)
        loaderView.centerYequalTo(constraint: overlay.centerYAnchor)

        loaderView.widthEqualTo(constant: 60)
        loaderView.heightEqualTo(constant: 60)
                
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.font = UIFont.localizedFont(size: .size13, weight: .regular)
            label.textColor = .white
            label.textAlignment = .center
            overlay.addSubview(label)
            label.center = overlay.center
            label.topEqualTo(constraint: loaderView.bottomAnchor,constant: 20)
            label.centerXequalTo(constraint: overlay.centerXAnchor)

            label.heightEqualTo(constant: 40)
            label.widthEqualTo(view: overlay)
        }
        DispatchQueue.main.async {
            activity.startAnimating()
        }
        // Animate the overlay to show
        UIView.animate(withDuration: 0.5) {
            overlay.alpha = overlay.alpha > 0 ? 0 : 0.8
        }
        
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        currentLoadingText = loadingText
    }
    
    static public func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentLoadingText = nil
            currentOverlayTarget = nil
        }
    }
}
