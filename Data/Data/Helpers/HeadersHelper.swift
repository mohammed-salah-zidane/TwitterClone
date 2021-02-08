//
//  HeadersHelper.swift
//  Data
//
//  Created by prog_zidane on 2/8/21.
//

import Foundation

class HeadersHelper {
    
    static func makeBaseOauthToken() -> String {
        let consumerKey = UserDefaultsKey.App.twitterConsumerKey.rawValue
        let consumerSecret = UserDefaultsKey.App.twitterConsumerSecret.rawValue
        let consumerKeyRFC1738 = consumerKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let consumerSecretRFC1738 = consumerSecret.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        let secretAndKeyData = concatenateKeyAndSecret.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let base64EncodeKeyAndSecret = secretAndKeyData?.base64EncodedString(options: NSData.Base64EncodingOptions())
        return base64EncodeKeyAndSecret!
    }
}
