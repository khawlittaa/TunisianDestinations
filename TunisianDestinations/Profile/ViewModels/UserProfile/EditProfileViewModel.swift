//
//  EditProfileViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/20/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class EditProfileViewModel{
    
    let validator = RegularExpressions()
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    @Published var items = [EditProfileCellViewModel]()
    
    @Published var user: User?{
        didSet{
            setUpUserinfo()
        }
    }
    
    func getProfileInfo() {
        self.task = ApiProfileClient.getUserInfo()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("profile info ")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    self.user = data
                    self.setUpUserinfo()
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
    
    func updateProfileInfo(){
        self.task = ApiProfileClient.updateProfileInfo(dateOfBirth: items[5].infovalue, lastname: items[1].infovalue, name: items[0].infovalue, phone: Int(items[4].infovalue) ?? 0)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(" UPdatrd profile info ")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    self.user = data
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
    
    func setUpUserinfo(){
        
        if let name = user?.firstName {
            let att = ProfileInformation(key:"First Name" ,value: name)
            items.append(EditProfileCellViewModel(userattribute: att))
        }
        
        if let last = user?.lastName {
            let att = ProfileInformation(key:"Last Name" ,value: last)
            items.append(EditProfileCellViewModel(userattribute: att))
        }
        
        if let phone = user?.phoneNumber{
            
            let att = ProfileInformation(key: "Phone Number", value: String(phone))
            items.append(EditProfileCellViewModel(userattribute: att))
        }
        
        if let bithday = user?.dateofBirth{
            
            let att = ProfileInformation(key: "Date of Birth", value: bithday)
            items.append(EditProfileCellViewModel(userattribute: att))
        }
        
    }
}
