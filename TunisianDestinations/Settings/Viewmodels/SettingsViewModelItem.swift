//
//  SettingsViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

protocol SettingsViewModelItem {
    var type: SettingsViewModelItemType { get }
    var rowCount: Int { get }
}

extension SettingsViewModelItem {
    var rowCount: Int {
        return 1
    }
}
