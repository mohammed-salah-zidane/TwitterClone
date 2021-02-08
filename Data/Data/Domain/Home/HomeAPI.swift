//
//  HomeAPI.swift
//  Data
//
//  Created by prog_zidane on 1/13/21.
//
import Moya

enum HomeAPI
{
    case getFollowers(request: FollowersRequest)
}

extension HomeAPI: TargetType
{
    var baseURL: URL
    {
        return Environments.shared.baseURL
    }
    
    var path: String
    {
        switch self
        {
        case .getFollowers:
            return "1.1/followers/list.json"
        }
    }
    
    var method: Moya.Method
    {
        switch self
        {
        case .getFollowers:
            return .get
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
        let token = UserTokenManager.accessToken ?? ""
        return ["Content-type": "application/json",
                "Authorization":"Bearer " + token,
                "oauth_consumer_key": UserDefaultsKey.App.twitterConsumerKey.rawValue]
    }
    
    var task: Task
    {
        switch self
        {
        case .getFollowers(let request):
            return .requestParameters(parameters: request.toJSONObject(), encoding: URLEncoding.queryString)
        }
    }
}
