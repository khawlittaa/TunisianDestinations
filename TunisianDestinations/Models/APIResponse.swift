//
//  APIResponse.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

enum APIResponseCodingKeys: String, CodingKey {
    case code
    case message
}
import Foundation
class APIResponse: Codable {
    var code: String?
    var message: String?
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: APIResponseCodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
    }
}
