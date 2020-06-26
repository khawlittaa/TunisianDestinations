//
//  APIController.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/10/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

  enum ApiError: Error {
      case badRequest               //Status code 400
      case notFound                //Status code 404
      case unAuthorized           //Status code 401
      case internalServerError   //Status code 500
  }

struct Constants {
    static let GooglePlacesAPIKey = "AIzaSyCu4D6DVCv9iNBwhv-7SSL7i577U9mBIgw"
    
    //The API's base URL
    static let baseURL = "http://3ichtounsi.apis.demo.proxym-it.net"
    
    //The parameters (Queries) that we're gonna use
    struct Parameters {
        static let token = "Bearer "
        static let eventId = "eventId"
        static let keyword = "keyword"
        static let startDate = "dateBegin"
        static let endDate = "dateEnd"
        static let idCategory = "idCategory"
        
        static let newPassword = "newPassword"
        static let oldPassword = "oldPassword"
        static let id = "id"
        static let dateOfBirth = "dateOfBirth"
        static let password = "password"
        static let username = "username"
        static let birthaDate = "dt"
        static let email = "email"
        static let lastname = "lastname"
        static let name = "name"
        static let phone = "phone"
        static let type = "type"
        
        static let adress = "address"
        static let googleplacesId = "googleplaces_id"
        static let userId = "idUser"
        static let latittude = "lat"
        static let longitude = "lng"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
        case multipart = "multipart/form-data"
        case text = "text/html; charset=utf-8"
    }
  
}

