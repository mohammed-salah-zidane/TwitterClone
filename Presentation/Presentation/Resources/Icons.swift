//
//  Icons.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import UIKit
enum Icons: String {
    case appLogo
    case dissapointmentImg
    case excuseText
    case backArrowWhite
    case backArrowOrange
    case invalidNameText
    case lockIcon
    case phone
    case profileIcon
    case removeButton
    case myroutes
    case trip
    case account
    case money
    case tabBar
    case car
    case about
    case history
    case logout
    case calendar
    case edit
    case icArrowBack
    case plus
    case terms
    case opps
    case done
    case sPin
    case dPin
    case privacy
    case firstPage
    case secondPage
    case thirdPage
    case fourthPage
    case engButtonIcon
    case arButtonIcon
    
    var image: UIImage! {
        guard let icon = UIImage(named: self.rawValue) else {
            return UIImage()
        }
        return icon
    }
}
