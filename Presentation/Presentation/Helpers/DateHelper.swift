//
//  DateHelper.swift
//  Rakeb user
//
//  Created by prog_zidane on 12/31/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation
import Core

public class DateHelper {
    
    static public let  appLocale = LocalizationManager.isArabicLang() ?  Locale(identifier: "ar") : Locale(identifier: "en")

    public enum DateFormat: String {
        case hours = "h:mm a"
        case fullDate = "dd/MM/yyyy"
    }
    
    static public func getString(from date: Date, with format: DateFormat = .hours ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = .current
        //formatter.locale = DateHelper.appLocale
        return formatter.string(from: date)
    }
    
    static public func date(from string: String, with format: DateFormat = .fullDate ) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = .current
        //formatter.locale = DateHelper.appLocale
        return formatter.date(from: string)
    }
}
