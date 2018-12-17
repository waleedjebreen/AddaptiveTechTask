//
//  LogInModel.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import Foundation

struct LogInResponseJSON : Codable {
    let iD : String?
    let fullName : String?
    let userName : String?
    let password : String?
    
    enum CodingKeys: String, CodingKey {
        
        case iD = "ID"
        case fullName = "FullName"
        case userName = "UserName"
        case password = "Password"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        password = try values.decodeIfPresent(String.self, forKey: .password)
    }
}

class LogInModel{
    static func logInUserWith(userName: String, password: String, complition: @escaping (_ isSucceeded: Bool?, _ result: [LogInResponseJSON]?, _ error: ErrorTypes.ErrorType?, _ statusCode: Int?) -> Void){
        let base = "https://barcaa.000webhostapp.com/signIn11.php?username=\(userName)&password=\(password)"
        let urlwithPercentEscapes = base.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        HttpRestManager.sendRequest(url: urlwithPercentEscapes, authorizationType: .None, method: .get, parameters: [String: Any](), headers: NSMutableDictionary()) { (result, error, statusCode) in
            if let json = result{
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode([LogInResponseJSON].self, from: json)
                    if !results.isEmpty{
                        if let _ = results[0].iD{
                            complition(true,results,nil, statusCode)
                        }else{
                            complition(false,nil,ErrorTypes.ErrorType.UserDoesNotExist, statusCode)
                        }
                    }else{
                        complition(false,nil,ErrorTypes.ErrorType.UserDoesNotExist, statusCode)
                    }
                } catch let error{
                    print("failed to convert data \(error)")
                    complition(false,nil,ErrorTypes.ErrorType.UserDoesNotExist, statusCode)
                }
            }else{
                complition(false,nil,ErrorTypes.ErrorType.UnknownError, statusCode)
            }
        }
    }
}
