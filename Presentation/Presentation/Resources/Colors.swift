//
//  Colors.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import UIKit

public enum Colors
{
    case orange
    case yellow
    case activityColor
    case underLineValidText
    case underLineErrorText
    case primary
    case background
    case darkBlue
    case navBackground
    case shadowColor
    
    public func withAlpha(_ alpha: Double) -> UIColor
    {
        return self.color.withAlphaComponent(CGFloat(alpha))
    }
    
    public var color: UIColor
    {
        switch self
        {
        case .background:return #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        case .navBackground: return #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        case .primary:return #colorLiteral(red: 0.1215686275, green: 0.737254902, blue: 0.9529411765, alpha: 1)
        case .darkBlue : return #colorLiteral(red: 0.1058823529, green: 0.2470588235, blue: 0.368627451, alpha: 1)
        case .orange:
            return UIColor(red: 242/255, green: 101/255, blue: 34/255, alpha: 1)
        case .yellow:
            return UIColor(red: 251/255, green: 169/255, blue: 25/255, alpha: 1)
        case .underLineValidText, .activityColor:
            return #colorLiteral(red: 0.1215686275, green: 0.737254902, blue: 0.9529411765, alpha: 1)
        case .underLineErrorText:
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case .shadowColor:
            return #colorLiteral(red: 0.8823529412, green: 0.9294117647, blue: 1, alpha: 1)
        }
    }
}
