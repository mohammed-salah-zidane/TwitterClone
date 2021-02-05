//
//  LocalizationManager.swift
//  Read On
//
//  Created by prog_zidane on 10/18/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import UIKit

public enum LanguageTypes: String
{
    case arabic = "ar"
    case english = "en"
}

public class LocalizationManager: NSObject
{
    private var currentBundle: Bundle!
    private var currentLanguage: LanguageTypes = .english
    private static var sharedManager: LocalizationManager =
    {
        let manager = LocalizationManager()
        return manager
    }()
    
    private override init()
    {
        super.init()
        adjustBundle()
    }
    
    private func adjustBundle()
    {
        let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj")
        currentBundle = Bundle(path: path!)
    }
    
    public class func localized(key: String) -> String
    {
        return sharedManager.currentBundle.localizedString(forKey: key, value: "not localized", table: nil)
        
    }
    
    public class func adjustLayoutDirection()
    {
        if sharedManager.currentLanguage == .arabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    public class func isArabicLang() -> Bool
    {
        return currentLangauge() == "ar"
    }
    
    public class func changeLanguage(_ lang: LanguageTypes)
    {
        sharedManager.currentLanguage = lang
        let defaults = UserDefaults.standard
        defaults.set([lang.rawValue == "en" ? "en" : "ar"], forKey: "AppleLanguages")
        defaults.set(lang.rawValue, forKey: "CURRENT_LANGUAGE")
        defaults.synchronize()
        adjustLayoutDirection()
        sharedManager.adjustBundle()
    }
    
    public class func currentLangauge() -> String
    {
        return (UserDefaults.standard.array(forKey:"AppleLanguages")?[0] as? String) ?? ""
    }
    
    public class func currentTextAlignment() -> NSTextAlignment
    {
        if sharedManager.currentLanguage == .arabic {
            return NSTextAlignment.left
        }else{
            return NSTextAlignment.right
        }
    }
}

//external func to shortcut the calling
public func localized(key: String) -> String
{
    return LocalizationManager.localized(key: key)
}

//external func to shortcut the calling
public func translate(key: String) -> String
{
    return LocalizationManager.localized(key: key)
}


public func isArabic() -> Bool
{
    return LocalizationManager.currentLangauge() == "ar"
}
