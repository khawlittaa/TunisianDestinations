//
//  ApiPlaceSubCategoriesRouter.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire

enum ApiPlaceSunCategoriesRouter: URLRequestConvertible,BaseRequestProtocol {
    
    typealias ResponseType = [PlaceSubCategory]
    
    //The endpoint name we'll call later
    case getPlaceSubCategories
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest
    {
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
        case .getPlaceSubCategories:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    internal var path: String {
        switch self {
        case .getPlaceSubCategories:
            return "/api/auth/subcategory"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    internal var parameters: Parameters? {
        switch self {
        case .getPlaceSubCategories:
        return nil        }
    }
}
