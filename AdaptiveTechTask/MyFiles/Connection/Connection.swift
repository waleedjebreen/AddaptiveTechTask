//
//  Connection.swift
//  TcheTche
//
//  Created by Waleed Jebreen on 11/24/16.
//  Copyright © 2016 Mozaic Innovative Solutions. All rights reserved.
//

import Foundation

class Connection {
    
    static func isConnected() -> Bool{
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            return false
            
        case .online(.wiFi) , .online(.wwan):
            return true
        }
    }
}
