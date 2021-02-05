//
//  ReachabilityManager.swift
//  Core
//
//  Created by prog_zidane on 1/9/21.
//
import Foundation
import Reachability

final public  class ReachabilityManger: NSObject {
    static public var shared = ReachabilityManger()
    private var reachability: Reachability? = {
        do {
            let rechability = try? Reachability()
            return rechability
        }
    }()
    
    private override init() {
        super.init()
    }
    
    public var connection: Reachability.Connection {
        return self.reachability?.connection ?? .none
    }
    
    public func checkReachability() {

        reachability?.whenUnreachable = { _ in
            NotifiyMessage.shared.toast(toastMessage: "Please check your internet connection and try again".localized)
        }
        
        reachability?.whenReachable = { _ in
            debugPrint("reachable")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            debugPrint("Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        guard let reachability = note.object as? Reachability else {return}
        switch reachability.connection {
        case .none:
            NotifiyMessage.shared.toast(toastMessage: "Please check your internet connection and try again".localized)
        default:
            return
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
}
