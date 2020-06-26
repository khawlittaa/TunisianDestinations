//
//  ApiEventsRouter.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/11/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Alamofire

enum ApiEventsRouter: URLRequestConvertible,BaseRequestProtocol {
    
    typealias ResponseType = [Event]
    
    //The endpoint name we'll call later
    case getEvent(eventId: Int)
    case getAllEvents
    case fillterEventByKeyword(keyword: String)
    case filterEventByCategory(categoryId:Double)
    case filterEventByDate(startDate:String, endDate: String)
    case filterEventsByDateAndCategory(startDate:String,endDate: String, categoryId:Double)
    
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
        
        //        urlRequest.setValue("", forHTTPHeaderField:Constants.HttpHeaderField
        //            .authentication.rawValue)
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
        case .getAllEvents:
            return .get
        case .getEvent(let eventId):
            return .get
        case .fillterEventByKeyword(let keyword):
            return .post
        case .filterEventByCategory(let categoryId):
            return .post
        case .filterEventByDate(let startDate, let endDate):
            return .post
        case .filterEventsByDateAndCategory(let startDate, let endDate, let categoryId):
            return .post
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    internal var path: String {
        switch self {
        case .getAllEvents:
            return "/api/auth/events"
        case .getEvent(let eventId):
            return "/api/auth/mobile/event/\(eventId)"
        case .fillterEventByKeyword:
            return "/api/auth/events/keyword"
        case .filterEventByCategory:
            return "/api/auth/events/cat"
        case .filterEventByDate:
            return "/api/auth/events/date"
        case .filterEventsByDateAndCategory:
            return "/api/auth/events/date/category"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    internal var parameters: Parameters? {
        switch self {
        case .getAllEvents:
            return nil
        case .getEvent(let eventId):
            //A dictionary of the key (From the constants file) and its value is returned
            return [Constants.Parameters.eventId : eventId]
        case .fillterEventByKeyword(let keyword):
            return [Constants.Parameters.keyword : keyword]
        case .filterEventByCategory(let categoryId):
            return [Constants.Parameters.id : categoryId]
        case .filterEventByDate(let startDate, let endDate):
            return [Constants.Parameters.startDate : startDate,Constants.Parameters.endDate : endDate]
        case .filterEventsByDateAndCategory(let startDate, let endDate, let categoryId):
            return [Constants.Parameters.startDate : startDate,Constants.Parameters.endDate : endDate, Constants.Parameters.idCategory: categoryId]
        }
    }
}
