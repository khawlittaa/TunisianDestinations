//
//  UserProfileRouter.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire

enum UserProfileRouter: URLRequestConvertible, BaseRequestProtocol {
    
    typealias ResponseType = User
    
    case getProfileInfo
    case updateProfileInfo(dateOfBirth: String, lastname:String, name: String, phone: Int )
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        //        if image case
        // urlRequest.setValue(Constants.ContentType.multipart.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        //        Content-Type: multipart/form-data"  -F "file=@star_filled.png;type=image/png
        let token: String = UserDefaults.standard.string(forKey: "token") ?? ""
        
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField:Constants.HttpHeaderField
            .authentication.rawValue)
        
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
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
        case .getProfileInfo:
            return .get
        case .updateProfileInfo(let dateOfBirth, let lastname, let name, let phone):
            return .post
        @unknown default:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    internal var path: String {
        switch self {
        case .getProfileInfo:
            return "/myprofile"
        case .updateProfileInfo(let dateOfBirth, let lastname, let name, let phone):
            return "/profile/update"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    internal var parameters: Parameters?
    {
        switch self {
        case .getProfileInfo:
            return nil
        case .updateProfileInfo(let dateOfBirth, let lastname, let name, let phone):
            return [Constants.Parameters.dateOfBirth : dateOfBirth, Constants.Parameters.lastname : lastname, Constants.Parameters.name: name, Constants.Parameters.phone: phone]
        }
    }
    
}

