//
//  Created by prog_zidane on 12/13/20.
//

import Moya


class MoyaProviderBuilder {
    static func makeProvider<Target: TargetType>() -> MoyaProvider<Target> {
        var config = NetworkLoggerPlugin.Configuration()

        // Log Options
        var logOptions = NetworkLoggerPlugin.Configuration.LogOptions()
        logOptions.insert(NetworkLoggerPlugin.Configuration.LogOptions.verbose)
        config.logOptions = logOptions

        // Formatter
        config.formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: jsonResponseDataFormatter)

        let logger = NetworkLoggerPlugin(configuration: config)

        return MoyaProvider<Target>(plugins: [logger])
    }
}

private func jsonResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(decoding: prettyData, as: UTF8.self)
    } catch {
        return String(decoding: data, as: UTF8.self)
    }
}
