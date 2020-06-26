//
//  EditFieldSettingViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine
class EditFieldSettingViewModelItem :SettingsViewModelItem{
    
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    var type: SettingsViewModelItemType{
        return .edit
    }
    
    var attribute: ProfileInformation
    var isEmail: Bool
    
    init(attribute: ProfileInformation, isEmail: Bool)
    {
        self.attribute = attribute
        self.isEmail = isEmail
    }
    
    func verifyEmail(email: String ) {
        self.task = ApiProfileClient.verifyEmail(email: attribute.infovalue!)
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     print("email verified & avaiable")
                     self.updateEmail(email: email)
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
    
    func updateEmail(email: String) {
        self.task = ApiProfileClient.UpdateEmail(email: attribute.infovalue!)
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     print("email updated ")
                 case let .failure(error):
                     print(error)
                     self.errorCode = error.localizedDescription
                     self.showAlert = true
                 }
             },
                   receiveValue: { data in
//                                         self. = data
                     self.errorCode = ""
                     self.showAlert = false
             })
     }
    
}
