//
//  IntExtension.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import Foundation
extension Int {
    
    public var seconds: Int {
        return self
    }
    
    public var minutes: Int {
        return self.seconds * 60
    }
    
    public var hours: Int {
        return self.minutes * 60
    }
    
    public var days: Int {
        return self.hours * 24
    }
    
    public var weeks: Int {
        return self.days * 7
    }
    
    public var months: Int {
        return self.weeks * 4
    }
    
    public var years: Int {
        return self.months * 12
    }
    
    public var clockFormat: String {
        let seconds: Int = self % 60
        let minutes: Int = (self / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Array {
    public func take(_ elementsCount: Int) -> [Element] {
        let min = Swift.min(elementsCount, count)
        return Array(self[0..<min])
    }
}
