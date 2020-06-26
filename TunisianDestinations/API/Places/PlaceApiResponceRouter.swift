//
//  PlaceApiResponceRouter.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/23/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire

enum PlaceApiResponceRouter: URLRequestConvertible,BaseRequestProtocol {
    
    typealias ResponseType = [APIResponse]
    
    //The endpoint name we'll call later
    case addFavorite(adress: String,googleplaceID: String ,userID: Int ,lat: Double ,long: Double ,placeName: String)
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest
    {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
//        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
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
        case .addFavorite:
            return .post
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    internal var path: String {
        switch self {
        case .addFavorite:
            return "/add/place/list"
//            +"\(Constants.Parameters.adress)=\(adress)&\(Constants.Parameters.googleplacesId)= \(googleplaceID)&\(Constants.Parameters.userId)=\(long)&\(Constants.Parameters.longitude)= \(adress)&\(Constants.Parameters.latittude)=\(lat)&\(Constants.Parameters.name)= \(placeName)"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    internal var parameters: Parameters? {
        switch self {
        case .addFavorite(let adress, let googleplaceID, let userID, let lat, let long, let placeName):
        return [Constants.Parameters.adress : adress,Constants.Parameters.googleplacesId : googleplaceID, Constants.Parameters.userId: userID, Constants.Parameters.longitude: long, Constants.Parameters.latittude: lat, Constants.Parameters.name: placeName]

        }
    }
}
