//
//  DeleteFieldSettingViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine
class DeleteSettingViewModelItem :SettingsViewModelItem{
    
    var type: SettingsViewModelItemType{
        return .delete
    }
    
    var settingMessage: String
    var isPassword: Bool
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    init(attribute: String,isPassword: Bool)
    {
        self.settingMessage = attribute
        self.isPassword = isPassword
    }
    
    func delete(id: Int){
        if settingMessage == "Delete Recent Activity"{
            deleteActivity(id: id)
        }
        else {
            if settingMessage == "Delete Account"{
                deleteAcccount(id: id)
                UserDefaults.standard.removeObject(forKey: "token")
            }
        } 
    }
    func deleteActivity(id: Int) {
        self.task = ApiProfileClient.deleteActivity(id:id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("activity deleted ")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    //                    self. = data
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
//    MARK:- get correct user id here 
    func deleteAcccount(id: Int) {
        self.task = ApiProfileClient.deleteAccount(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("account deleted ")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    //                    self. = data
                    self.errorCode = ""
                    self.showAlert = false
            })
    }

    
}
