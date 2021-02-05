import Foundation

struct LocaleStore {
    
    /// Result Enum
    ///
    /// - Success: Returns Grouped By Alphabets Locale Info
    /// - Error: Returns error
    public enum GroupedByAlphabetsFetchResults {
        case success(response: [String: [LocaleInfo]])
        case error(error: (title: String?, message: String?))
    }
    
    /// Result Enum
    ///
    /// - Success: Returns Array of Locale Info
    /// - Error: Returns error
    public enum FetchResults {
        case success(response: [LocaleInfo])
        case error(error: (title: String?, message: String?))
    }
    
    public static func getInfo(completionHandler: @escaping (FetchResults) -> ()) {
        let bundle = Bundle(for: LocalePickerViewController.self)
        let path = "Countries.bundle/Data/CountryCodes"
        
        guard let jsonPath = bundle.path(forResource: path, ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
                let error: (title: String?, message: String?) = (title: "ContryCodes Error", message: "No ContryCodes Bundle Access")
                return completionHandler(FetchResults.error(error: error))
        }
        
        if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)) as? Array<Any> {
            var result: [LocaleInfo] = []
            for jsonObject in jsonObjects {
                guard let countryObj = jsonObject as? Dictionary<String, Any> else { continue }
                guard let country = self.countryName(country: (countryObj["code"] as? String) ?? "PS"),
                    let code = countryObj["code"] as? String,
                    let phoneCode = countryObj["dial_code"] as? String else {
                        continue
                }
                var countrry: String = country
                let coode = code
                if code == "PS" {
                    countrry = "Palestine".localized
                }
                let new = LocaleInfo(country: countrry, code: coode, phoneCode: phoneCode)
                result.append(new)
            }
            return completionHandler(FetchResults.success(response: result))
        }
        
        let error: (title: String?, message: String?) = (title: "JSON Error", message: "Couldn't parse json to Info")
        return completionHandler(FetchResults.error(error: error))
    }
    public static func countryName(country: String) -> String? {
        
        let current = Locale(identifier: LanguageManager.shared.isRTL() ? "ar" : "en")
        return current.localizedString(forRegionCode: country)
    }
    
    public static func fetch(completionHandler: @escaping (GroupedByAlphabetsFetchResults) -> ()) {
        LocaleStore.getInfo { result in
            switch result {
            case .success(let info):
                /*
                 var header = Set<String>()
                 info.forEach {
                 let country = $0.country
                 header.insert(String(country[country.startIndex]))
                 }
                 */
                var data = [String: [LocaleInfo]]()
                
                info.forEach {
                    let country = $0.country
                    let index = String(country[country.startIndex])
                    var value = data[index] ?? [LocaleInfo]()
                    value.append($0)
                    data[index] = value
                }
                
                data.forEach { key, value in
                    data[key] = value.sorted(by: { lhs, rhs in
                        return lhs.country < rhs.country
                    })
                }
                completionHandler(GroupedByAlphabetsFetchResults.success(response: data))
                
            case .error(let error):
                completionHandler(GroupedByAlphabetsFetchResults.error(error: error))
            }
        }
    }
}


class LanguageManager {
    
    static let shared = LanguageManager()
    
    let APPLE_LANGUAGE_KEY = "AppleLanguages"
    
    func isRTL() -> Bool {
        let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>
        return (langs?.first?.hasPrefix("ar"))! ? true : false
    }
    
    func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }
    
    func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
