//
//  Login.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/12/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

  enum UserCredentialsCodingKeys: String, CodingKey {
      case id
      case username
      case type
      case token
  }

class UserCredentials: Codable{
  
    var token: String
    var userID : Double
    var userName: String
    var accountType: String
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCredentialsCodingKeys.self)
        token = try container.decode(String.self, forKey: .token)
        userID = try container.decode(Double.self, forKey: .id)
        userName = try container.decode(String.self, forKey: .username)
        accountType = try container.decode(String.self, forKey: .type)
    }
    
}
