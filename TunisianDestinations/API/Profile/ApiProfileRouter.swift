//
//  ApiProfileRouter.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire

enum ApiProfileRouter: URLRequestConvertible, BaseRequestProtocol {
    
    typealias ResponseType = APIResponse
    
    /// note: add file here
    case updateEmail(email: String)
    case updatePassword(oldpassword: String, newPassword: String)
    case verifyUserName(userName: String)
    case verifyEmail(email:String)
    case deleteAccount(id: Int)
    case deletePhone
    case deleteActivity(id: Int)
    

    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
//            = data(using: .utf8, allowLossyConversion: false)
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
//        urlRequest.setValue(Constants.ContentType.text.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
         let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField:Constants.HttpHeaderField
            .authentication.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    internal var method: HTTPMethod {
        switch self {
        case .updateEmail:
            return .post
        case .updatePassword:
             return .post
        case .verifyUserName:
             return .post
        case .verifyEmail:
             return .post
        case .deleteAccount:
             return .get
        case .deletePhone:
             return .get
        case .deleteActivity:
             return .get
        @unknown default:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    internal var path: String {
        switch self {
        case .updateEmail:
            return "/profile/update/email"
        case .updatePassword(let oldpassword, let newPassword):
//        return [Constants.Parameters.newPassword : newPassword, Constants.Parameters.oldPassword : oldpassword]
            return "/update/password/"
        case .verifyUserName:
            return "/verif/username"
        case .verifyEmail:
            return "/verif/email"
        case .deleteAccount(let id):
            return "/delete/user/\(id)"
        case .deletePhone:
            return "/delete/phone"
        case .deleteActivity(let id):
            return "delete/activity/\(id)"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    internal var parameters: Parameters? {
        switch self {
        case .updateEmail(let email):
        return [Constants.Parameters.email : email]
        case .updatePassword(let oldpassword, let newPassword):
        return [Constants.Parameters.newPassword : newPassword, Constants.Parameters.oldPassword : oldpassword]
        case .verifyUserName(let userName):
        return [Constants.Parameters.username : userName]
        case .verifyEmail(let email):
        return [Constants.Parameters.email : email]
        case .deleteAccount:
        return nil
        case .deletePhone:
        return nil
        case .deleteActivity(let id):
        return nil
        }
    }
    
}

