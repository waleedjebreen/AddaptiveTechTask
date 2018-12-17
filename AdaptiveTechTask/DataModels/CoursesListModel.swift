//
//  CoursesListModel.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import Foundation
struct CoursesListResponseJSON : Codable {
    let couseID : String?
    let userID : String?
    let couseName : String?
    let couseDesc : String?
    let couseImage : String?
    let pdfURL : String?
    
    enum CodingKeys: String, CodingKey {
        
        case couseID = "CouseID"
        case userID = "UserID"
        case couseName = "CouseName"
        case couseDesc = "CouseDesc"
        case couseImage = "CouseImage"
        case pdfURL = "pdfURL"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        couseID = try values.decodeIfPresent(String.self, forKey: .couseID)
        userID = try values.decodeIfPresent(String.self, forKey: .userID)
        couseName = try values.decodeIfPresent(String.self, forKey: .couseName)
        couseDesc = try values.decodeIfPresent(String.self, forKey: .couseDesc)
        couseImage = try values.decodeIfPresent(String.self, forKey: .couseImage)
        pdfURL = try values.decodeIfPresent(String.self, forKey: .pdfURL)
    }
}

class CoursesListModel{
    static func getCourses(complition: @escaping (_ isSucceeded: Bool?, _ result: [CoursesListResponseJSON]?, _ error: ErrorTypes.ErrorType?, _ statusCode: Int?) -> Void){
        HttpRestManager.sendRequest(url: "https://barcaa.000webhostapp.com/getCoursesList.php", authorizationType: .None, method: .get, parameters: [String: Any](), headers: NSMutableDictionary()) { (result, error, statusCode) in
            if let json = result{
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode([CoursesListResponseJSON].self, from: json)
                    if !results.isEmpty{
                        complition(true,results,nil, statusCode)
                    }else{
                        complition(false,nil,ErrorTypes.ErrorType.UnknownError, statusCode)
                    }
                    
                    
                } catch let error{
                    print("failed to convert data \(error)")
                    complition(false,nil,ErrorTypes.ErrorType.UnknownError, statusCode)
                }
            }else{
                complition(false,nil,ErrorTypes.ErrorType.UnknownError, statusCode)
            }
        }
    }
}
