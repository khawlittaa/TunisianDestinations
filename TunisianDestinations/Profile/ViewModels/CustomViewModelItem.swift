//
//  ProfileViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

protocol CustomViewModelItem {
    var type: ProfileViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension CustomViewModelItem {
    var rowCount: Int {
        return 1
    }
}
