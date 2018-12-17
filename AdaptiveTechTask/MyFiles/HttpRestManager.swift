//
//  HttpRestManager.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import Foundation
import Alamofire

//MARK:- Authorization Enum
public enum AuthorizationType: String {
    case SessionToken = "SessionToken"
    case TempSessionToken = "TempSessionToken"
    case Authorization = "Authorization"
    case None
}

class AuthorizationManager{
    
    static func getAuthenticationToken(authorizationType: AuthorizationType) -> String?{
        let defaults = UserDefaults.standard
        switch authorizationType {
        case .TempSessionToken:
            if let tempSessionToken = defaults.string(forKey: AuthorizationType.TempSessionToken.rawValue){
                return tempSessionToken
            }
        case .SessionToken:
            if let sessionToken = defaults.string(forKey: AuthorizationType.SessionToken.rawValue){
                return sessionToken
            }
        case .Authorization:
            if let authorization = defaults.string(forKey: AuthorizationType.Authorization.rawValue){
                return authorization
            }
        case .None:
            break
        }
        return nil
    }
    
    static func setAuthenticationToken(_ authorizationType: AuthorizationType, value: String?){
        let defaults = UserDefaults.standard
        switch authorizationType {
        case .TempSessionToken:
            defaults.set(value, forKey: AuthorizationType.TempSessionToken.rawValue)
        case .SessionToken:
            defaults.set(value, forKey: AuthorizationType.SessionToken.rawValue)
        case .Authorization:
            defaults.set(value, forKey: AuthorizationType.Authorization.rawValue)
        case .None:
            break
        }
    }
}

class HttpRestManager{
    public static func sendRequest(url: String, authorizationType: AuthorizationType, method: HTTPMethod, parameters: [String: Any]?, headers: NSMutableDictionary, complition: @escaping (_ results: Data?, _ errors: Error?, _ statusCode: Int?) -> Void){
        let preparedHeaders = prepareHeaders(headers: headers, authorizationType: authorizationType)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: preparedHeaders).responseData { (response) in
            switch response.result{
            case .success(let value):
                complition(value, nil, response.response?.statusCode)
            case .failure(let error):
                complition(nil, error, response.response?.statusCode)
            }
        }
    }
    
    public static func prepareHeaders(headers: NSMutableDictionary, authorizationType: AuthorizationType) -> HTTPHeaders{
        
        let allHeaders = headers
        
        switch authorizationType {
        case .TempSessionToken:
            if let authinticationToken = AuthorizationManager.getAuthenticationToken(authorizationType: .TempSessionToken){
                allHeaders[AuthorizationType.TempSessionToken.rawValue] = authinticationToken
            }
            
        case .SessionToken:
            if let authinticationToken = AuthorizationManager.getAuthenticationToken(authorizationType: .SessionToken){
                allHeaders[AuthorizationType.SessionToken.rawValue] = authinticationToken
            }
            
        case.Authorization:
            if let authinticationToken = AuthorizationManager.getAuthenticationToken(authorizationType: .Authorization){
                allHeaders[AuthorizationType.Authorization.rawValue] = authinticationToken
            }
            
        case .None:
            break
        }
        allHeaders["Content-Type"] = "application/json; charset=utf-8"

        return allHeaders as! HTTPHeaders
    }
}
