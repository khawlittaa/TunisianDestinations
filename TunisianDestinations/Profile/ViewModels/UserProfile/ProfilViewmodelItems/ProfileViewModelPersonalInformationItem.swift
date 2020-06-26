//
//  ProfileViewModelPersonalInformationItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class ProfileViewModelPersonalInformationItem: CustomViewModelItem {
    var type: ProfileViewModelItemType {
        return .personalInformation
    }
    
    var sectionTitle: String {
        return "Personal Information"
    }

    var rowCount: Int {
       return attributes.count
    }
    
    var attributes: [ProfileInformation]
    
    init(attributes: [ProfileInformation]) {
        self.attributes = attributes
    }
}
