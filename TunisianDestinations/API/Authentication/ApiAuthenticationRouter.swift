//
//  ApiAuthenticationRouter.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/12/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire

enum ApiAuthenticationRouter: URLRequestConvertible, BaseRequestProtocol {
    
    typealias ResponseType = UserCredentials
    
    case loginUser(userName: String, password: String)
    case registerUser(firstname: String, lastname: String, userName: String, email: String, password: String, birthDate: String, accountType: String)
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    internal var method: HTTPMethod {
        switch self {
        case .loginUser(let userName, let password):
             return .post
        case .registerUser( let firstname,let  lastname, let userName,let  email,let password, let birthDate, let accountType):
             return .post
        @unknown default:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    internal var path: String {
        switch self {
        case .registerUser( let firstname,let  lastname, let userName,let  email,let password, let birthDate, let accountType):
            return "/api/auth/signup"
        case .loginUser(let userName, let password):
            return "/api/auth/signin"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    internal var parameters: Parameters? {
        switch self {
        case .loginUser(let userName, let password):
            return [Constants.Parameters.password : password, Constants.Parameters.username: userName]
        case .registerUser( let firstname,let  lastname, let userName,let  email,let password, let birthDate, let accountType):
            return [Constants.Parameters.birthaDate : birthDate, Constants.Parameters.email: email,Constants.Parameters.lastname : lastname, Constants.Parameters.name: firstname, Constants.Parameters.password : password, Constants.Parameters.type : accountType, Constants.Parameters.username: userName]
        }
    }
    
}
