//
//  Errors.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import Foundation

struct Errors : Codable {
    let errorCode : Int?
    let errorMessage : String?
    
    enum CodingKeys: String, CodingKey {
        
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}

class ErrorTypes{
    enum ErrorType: Int{
        case None = 0
        case InvalidPropertyValue = 1
        case UnAuthinticatedUser = 2
        case InternalServerError = 3
        case UserDoesNotExist = 4
        case InvalidVerificationCode = 5
        case ExpiredVerificationCode = 6
        case DeviceNotActive = 7
        case ResendActivationCodePeriod = 8
        case ReferralCodeNotExist = 9
        case AlreadyEnteredReffarlCode = 10
        case SelfUserCode = 11
        case NoEnoughBalance = 12
        case TransferForSameUser = 13
        case CannotGetPromotionInfo = 14
        case OrderAmountDoesNotReachtheMinimumValue = 15
        case PromoCodeNotExists = 16
        case NotActivated = 17
        case PromoCodeUsed = 18
        case Expired = 19
        case UserInActive = 20
        case OutOfStock = 21
        case NotEnoughPoints = 22
        case RewardCanBeRedeemedOnce = 23
        case FailedToConvertJSON = 91
        case UnknownError = 92
    }
    
    static func getErrorTypeFrom(errors: [Errors]?) -> ErrorType?{
        guard let unrappedErrors = errors else { return nil }
        if !unrappedErrors.isEmpty{
            guard let errorCode = unrappedErrors[0].errorCode else { return nil }
            
            switch errorCode{
            case ErrorType.None.rawValue:
                return ErrorType.None
                
            case ErrorType.InvalidPropertyValue.rawValue:
                return .InvalidPropertyValue
                
            case ErrorType.UnAuthinticatedUser.rawValue:
                return .UnAuthinticatedUser
                
            case ErrorType.InternalServerError.rawValue:
                return .InternalServerError
                
            case ErrorType.UserDoesNotExist.rawValue:
                return .UserDoesNotExist
                
            case ErrorType.InvalidVerificationCode.rawValue:
                return .InvalidVerificationCode
                
            case ErrorType.ExpiredVerificationCode.rawValue:
                return .ExpiredVerificationCode
                
            case ErrorType.DeviceNotActive.rawValue:
                return .DeviceNotActive
                
            case ErrorType.ResendActivationCodePeriod.rawValue:
                return .ResendActivationCodePeriod
                
            case ErrorType.ReferralCodeNotExist.rawValue:
                return .ReferralCodeNotExist
                
            case ErrorType.AlreadyEnteredReffarlCode.rawValue:
                return .AlreadyEnteredReffarlCode
                
            case ErrorType.SelfUserCode.rawValue:
                return .SelfUserCode
                
            case ErrorType.NoEnoughBalance.rawValue:
                return .NoEnoughBalance
                
            case ErrorType.TransferForSameUser.rawValue:
                return .TransferForSameUser
                
            case ErrorType.CannotGetPromotionInfo.rawValue:
                return .CannotGetPromotionInfo
                
            case ErrorType.OrderAmountDoesNotReachtheMinimumValue.rawValue:
                return .OrderAmountDoesNotReachtheMinimumValue
                
            case ErrorType.PromoCodeNotExists.rawValue:
                return .PromoCodeNotExists
                
            case ErrorType.NotActivated.rawValue:
                return .NotActivated
                
            case ErrorType.PromoCodeUsed.rawValue:
                return .PromoCodeUsed
                
            case ErrorType.Expired.rawValue:
                return .Expired
                
            case ErrorType.UserInActive.rawValue:
                return .UserInActive
                
            case ErrorType.OutOfStock.rawValue:
                return .OutOfStock
                
            case ErrorType.NotEnoughPoints.rawValue:
                return .NotEnoughPoints
                
            case ErrorType.RewardCanBeRedeemedOnce.rawValue:
                return .RewardCanBeRedeemedOnce
                
            default:
                return nil
            }
        }else{
            return nil
        }
    }
}
