//
//  ApiAuthenticationClient.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/12/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Alamofire
import Combine

class ApiAuthenticationClient{
    static func logInUser(userName: String, password: String) -> Future<UserCredentials, Error>{
        return NetworkPublisher.publish(ApiAuthenticationRouter.loginUser(userName: userName, password: password))
    }
    
    static func registerUser(firstname: String, lastname: String, userName: String, email: String, password: String, birthDate: String, accountType: String) -> Future<APIResponse, Error>{
        return NetworkPublisher.publish(APISignUpRouter.registerUser(birthDate: birthDate, email: email , lastname: lastname, firstname: firstname, password: password, accountType: accountType, userName: userName))
       }
}
