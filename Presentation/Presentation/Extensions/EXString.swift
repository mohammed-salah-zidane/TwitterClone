//
//  EXString.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import Foundation
import UIKit

public extension String {
    /// Returns if a string hasn't whitespaces And Newlines
    var trimmed:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    var attributes : [NSAttributedString.Key: Any]  {
        return [
            NSAttributedString.Key.font : UIFont.localizedFont(size: .size15, weight: .medium),
            NSAttributedString.Key.foregroundColor : Colors.primary.color, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
    }
    
    var html2String: String {
        guard
            let data = data(using: .utf8),
            let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            else {
                return self
        }
        return attributedString.string
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailTest.evaluate(with: self)
        return isValid
    }
    
    var isValidPhone: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var isValidSaudiNumber: Bool {
        guard self.hasPrefix("+966") || self.hasPrefix("00966") else {
            return false
        }
        return true
    }
    
    var isValidPhoneLength: Bool {
        guard self.count == 9 && self.isValidPhone else {
            return false
        }
        return true
    }
    
    func isValidPhoneLength(length: Int) -> Bool {
        guard self.count == length && self.isValidPhone else {
            return false
        }
        return true
    }
    
    var isValidForUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        if !UIApplication.shared.canOpenURL(url) {
            return false
        }
        return true
    }
    
    public func isURL() -> Bool {
        return URL(string: self) != nil
    }
    
    func isBirthDateGreaterThan(_ years: Int) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateOfBirth = dateFormatter.date(from: self)!
        
        let today = Date()
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let age = gregorian.components([.year], from: dateOfBirth, to: today, options: [])
        
        if age.year! < years {
            return false
        }
        return true
    }
    
    var englishNumber: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    func dialNumber() {
        if let url = URL(string: "tel://\(self)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("unvalid number")
        }
    }
    func openURL(){
        if let url = URL(string: self) {
            UIApplication.shared.open(url)
        }
    }
    
    func index(from: Int) -> Index {
           return self.index(startIndex, offsetBy: from)
       }

       func substring(from: Int) -> String {
           let fromIndex = index(from: from)
           return String(self[fromIndex...])
       }

       func substring(to: Int) -> String {
           let toIndex = index(from: to)
           return String(self[..<toIndex])
       }

       func substring(with r: Range<Int>) -> String {
           let startIndex = index(from: r.lowerBound)
           let endIndex = index(from: r.upperBound)
           return String(self[startIndex..<endIndex])
       }
}
