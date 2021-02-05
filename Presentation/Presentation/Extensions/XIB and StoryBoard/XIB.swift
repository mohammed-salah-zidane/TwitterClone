//
//  XIB.swift
//
//  Refactored by Essam Mohamed Fahmi on 9/24/20.
//

import UIKit

extension UIView
{
    public static var nib: UINib
    {
        return UINib(nibName: "\(self)", bundle: Bundle(for: Self.self))
    }
    
    public static func instantiateFromNib() -> Self?
    {
        return nib.instantiate() as? Self
    }
    
    public func loadXIBFromMemory()
    {
        Bundle(for: Self.self).loadNibNamed("\(Self.self)", owner: self, options:nil)
    }
}

extension UINib
{
    public func instantiate() -> Any?
    {
        return instantiate(withOwner: nil, options: nil).first
    }
}
