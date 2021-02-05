//
//  LocalizableFont.swift
//  Presentation
//
//  Created by prog_zidane on 1/6/21.
//
import UIKit
import Core

public enum FontWeight {
    case light
    case regular
    case bold
    case medium
}

public enum FontSize: CGFloat {
    case size11 = 11
    case size12 = 12
    case size13 = 13
    case size14 = 14
    case size15 = 15
    case size16 = 16
    case size17 = 17
    case size18 = 18
    case size20 = 20
    case size21 = 21
    case size22 = 22
    case size25 = 25
    case size35 = 35
    case size40 = 40
    case size48 = 48
}

extension UIFont {
    public static func localizedFont(size fontSize: FontSize = .size18, weight: FontWeight) -> UIFont {
        switch weight {
        case .regular:
            return isArabic() ?
                FontFamily.DINNextLTArabic.regular.font(size: fontSize.rawValue) :
                FontFamily.DINNextLTArabic.regular.font(size: fontSize.rawValue)
        case .bold:
            return isArabic() ?
                FontFamily.DINNextLTArabic.bold.font(size: fontSize.rawValue) :
                FontFamily.DINNextLTArabic.bold.font(size: fontSize.rawValue)
        case .medium:
            return isArabic() ?
                FontFamily.DINNextLTArabic.medium.font(size: fontSize.rawValue) :
                FontFamily.DINNextLTArabic.medium.font(size: fontSize.rawValue)
        case .light:
            return isArabic() ?
                FontFamily.DINNextLTArabic.light.font(size: fontSize.rawValue) :
                FontFamily.DINNextLTArabic.light.font(size: fontSize.rawValue)
        }
    }
}
