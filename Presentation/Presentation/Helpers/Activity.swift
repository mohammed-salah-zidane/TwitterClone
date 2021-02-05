//
//  Indicator.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import NVActivityIndicatorView
import Core

public protocol ActivitayActionsDelegate: class
{
    static func startAnimating(withBackground: Bool)
    static func stopAnimating()
}

public final class Activity: NSObject, ActivitayActionsDelegate
{
    private static let restorationIdentifier: String = "NVActivityIndicator"
    private static var currentView: UIView?
    {
        get
        {
            guard let topView = UIApplication.getTopViewController()?.view else { return nil }
            return topView
        }
    }
    
    public static func startAnimating(withBackground: Bool = false)
    {
        Activity.stopAnimating()
        
        guard let currentView = currentView else { return }
        let loaderView = DesignableView()
        loaderView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loaderView.cornerRadius = 10
        
        if withBackground
        {
            loaderView.backgroundColor = .white
        }
        
        let activity = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width / 2 ,
                                                             y: UIScreen.main.bounds.height / 2,
                                                             width: 50,
                                                             height: 50),
                                               type: .ballClipRotatePulse,
                                               color: Colors.activityColor.color,
                                               padding: 0.0)
        
        activity.center = loaderView.center
        loaderView.center = currentView.center
        loaderView.restorationIdentifier = restorationIdentifier
        loaderView.addSubview(activity)
        currentView.addSubview(loaderView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentView.bringSubviewToFront(loaderView)
        }
        
        activity.startAnimating()
    }
    
    public static func stopAnimating()
    {
        guard let currentView = currentView else { return }
        for item in currentView.subviews where item.restorationIdentifier == restorationIdentifier
        {
            item.removeFromSuperview()
        }
    }
}
