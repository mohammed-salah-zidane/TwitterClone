//
//  NotificationsMessages.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Toast_Swift
import SwiftMessages


public final class NotifiyMessage
{
    private init() {}
    public static let shared = NotifiyMessage()
    public typealias CompletionHandler = () -> Void

    public func configNotify()
    {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
        ToastManager.shared.duration = 2
    }
    
    public func toast(toastMessage: String,position: ToastPosition = .bottom, completion: (() -> Void)? = nil)
    {
        configNotify()
        guard let view = UIApplication.getTopViewController()?.view else { return }
        ToastManager.shared.position = position
        view.makeToast(toastMessage) { _ in
            completion?()
        }
    }
    
    public func notify(title:String = "Rakeb team".localized, message:String , icon:UIImage? = nil, buttonTitle:String = "", _ completionHandler: @escaping CompletionHandler = {}){
        let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
        
        messageView.configureBackgroundView(width: UIScreen.main.bounds.width * 0.8)
        messageView.configureContent(title: title, body: message, iconImage: icon, iconText: nil, buttonImage: nil, buttonTitle: buttonTitle) { _ in
            SwiftMessages.hide()
            completionHandler()
        }
        messageView.titleLabel?.textColor = .appDarkBlue
        messageView.bodyLabel?.textColor = .lightGray
        messageView.backgroundView.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        messageView.backgroundView.layer.cornerRadius = 10
        messageView.titleLabel?.font = UIFont.localizedFont(size: .size22, weight: .bold)
        messageView.bodyLabel?.font = UIFont.localizedFont(size: .size13, weight: .medium)
        messageView.button?.titleLabel?.font = UIFont.localizedFont(size: .size17, weight: .medium)
        messageView.button?.tintColor = .white
        messageView.button?.maskedRoundedCorners(corners: [.bottomLeft,.bottomRight,.topLeft,.topRight],amount: 5)
        messageView.button?.backgroundColor = .appPrimary
        messageView.button?.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.interactiveHide = false
        config.duration = .forever
        config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: false)
        config.presentationContext  = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: config, view: messageView)
    }
}
