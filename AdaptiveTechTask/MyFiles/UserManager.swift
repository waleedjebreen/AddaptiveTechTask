//
//  UserManager.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import Foundation

class UserManager{
    static var isRegistered: Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "IsRegistered")
        }
        get{
            let isCompleted = UserDefaults.standard.bool(forKey: "IsRegistered")
            return isCompleted
        }
    }
}
