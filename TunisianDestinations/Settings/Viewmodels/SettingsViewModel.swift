//
//  SettingsViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class SettingsViewModel {
    
   @Published var items = [SettingsViewModelItem]()
    
    init() {
        //MARK: ASK RIMA chould i save email, psw and phone in user default when user is looged in
        // from user Defaukts
        
//        let num = ProfileInformation(key: "Personal Informations", value: "")
//        let info = EditFieldSettingViewModelItem(attribute: num, isEmail: false)
//        items.append(info)
        
        let mail = ProfileInformation(key: "Email", value: "mail@email.com")
        let  email = EditFieldSettingViewModelItem(attribute: mail, isEmail: true)
        items.append(email)
        
        let password = DeleteSettingViewModelItem(attribute: "Update Password", isPassword: true)
        items.append(password)
        let deleteActivity = DeleteSettingViewModelItem(attribute: "Delete Recent Activity", isPassword: false)
        items.append(deleteActivity)
        let deleteaccount = DeleteSettingViewModelItem(attribute: "Delete Account", isPassword: false)
        items.append(deleteaccount)
    }
    
}
