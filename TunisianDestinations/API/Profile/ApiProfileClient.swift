//
//  ApiProfileClient.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class ApiProfileClient {
    
    static func getUserInfo() -> Future<User, Error>{
        return NetworkPublisher.publish(UserProfileRouter.getProfileInfo)
        }
    
    static func updateProfileInfo(dateOfBirth: String, lastname:String, name: String, phone: Int)-> Future<User, Error>{
    return NetworkPublisher.publish(UserProfileRouter.updateProfileInfo(dateOfBirth: dateOfBirth, lastname: lastname, name: name, phone: phone))
    }
    
    static func UpdatePassword(oldpassword: String, newPassword: String) -> Future<APIResponse, Error>{
    return NetworkPublisher.publish(ApiProfileRouter.updatePassword(oldpassword: oldpassword, newPassword: newPassword))
    }
    
    static func verifyEmail(email: String) -> Future<APIResponse, Error>{
             return NetworkPublisher.publish(ApiProfileRouter.verifyEmail(email: email))
         }
    
    static func UpdateEmail(email: String) -> Future<APIResponse, Error>{
          return NetworkPublisher.publish(ApiProfileRouter.updateEmail(email: email))
      }
    
    static func deleteAccount(id: Int) -> Future<APIResponse, Error>{
    return NetworkPublisher.publish(ApiProfileRouter.deleteAccount(id: id))
    }
    
    static func deleteActivity(id: Int) -> Future<APIResponse, Error>{
        return NetworkPublisher.publish(ApiProfileRouter.deleteActivity(id: id))
    }
    
    
}
