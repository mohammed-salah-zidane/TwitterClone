//
//  Created by prog_zidane on 12/13/20.
//

import Foundation

public class ApiConstants {
    static public let requestTokenURL = "\(Environments.shared.baseURL)oauth/request_token"
    static public let authorizeURL = "\(Environments.shared.baseURL)oauth/authorize"
    static public let accessTokenURL = "\(Environments.shared.baseURL)oauth/access_token"
    static public let twitterCallBackURL = "twittter-clone://oauth-callback/twitter"
}
