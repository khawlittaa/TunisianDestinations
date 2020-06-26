//
//  ProfileInformation.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class ProfileInformation{
    var infoKey: String?
    var infovalue: String?
    var editable: Bool? 
    
    init(key: String, value: String, editable: Bool = true) {
        infoKey = key
        infovalue = value
        self.editable = editable
    }
}
