//
//  AuthAPI.swift
//  Data
//
//  Created by prog_zidane on 2/8/21.
//
import Moya

enum AuthAPI
{
    case requestAccessToken
}

extension AuthAPI: TargetType
{
    var baseURL: URL
    {
        return Environments.shared.baseURL
    }
    
    var path: String
    {
        switch self
        {
        case .requestAccessToken:
            return "oauth2/token"
        }
    }
    
    var method: Moya.Method
    {
        switch self
        {
        case .requestAccessToken:
            return .post
        }
    }
    
    var sampleData: Data
    {
        switch self
        {
        default:
            return Data()
        }
    }
    
    var headers: [String : String]?
    {
        return ["Content-type": "application/x-www-form-urlencoded;charset=UTF-8",
                "Authorization":"Basic \(HeadersHelper.makeBaseOauthToken())"
        ]
    }
    
    var task: Task
    {
        switch self
        {
        case .requestAccessToken:
            let param = ["grant_type": "client_credentials"]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}
