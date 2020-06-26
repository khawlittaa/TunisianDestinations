//
//  UserProfileViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import Combine

class UserProfileViewModel: NSObject{
    
    @Published var items = [CustomViewModelItem]()
    @Published var attributes = [ProfileInformation]()
    @Published var places = [Place]()
    @Published var myActivities = [String]()
    @Published var events = [String]()
    
    @Published var profile: User?{
        didSet{
            print("profile did set")
            //            fillProfile()
        }
    }
    
    @Published private(set) var state: ListViewModelState = .loading
    private var bindings = Set<AnyCancellable>()
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    
    override init() {
        super.init()
    }
    
    private(set) lazy var onAppear: () -> Void = { [weak self] in
        self?.items = [CustomViewModelItem]()
        self?.getProfileInfo()
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
                    self.items = [CustomViewModelItem]()
                    self.profile = data
                    UserDefaults.standard.set(data.userID, forKey: "id")
                    self.fillProfile()
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
    
    func fillProfile(){
        items = [CustomViewModelItem]()
        attributes = [ProfileInformation]()
        if let userName = profile?.userName, let name = profile?.firstName ,let last = profile?.lastName, let id = profile?.userID {
            let fullName = "\(name) \(last)"
            let nameAndPictureItem = ProfileViewModelNameAndPictureItem(pictureUrl: profile?.pictureUrl, userName: userName, fullName: fullName, userID: id)
            items.append(nameAndPictureItem)
        }
        
        if let email = profile?.email {
            let att = ProfileInformation(key: "Email Address", value: email)
            attributes.append(att)
        }
        
        if let  type = profile?.accountType {
            
            let att = ProfileInformation(key: "Account type", value: type)
            attributes.append(att)
        }
        
        if let phone = profile?.phoneNumber{
            if phone > 0 {
                
                let att = ProfileInformation(key: "Phone Number", value: String(phone))
                attributes.append(att)
            }
        }
        
        if let bithday = profile?.dateofBirth{
            
            let att = ProfileInformation(key: "Date of Birth", value: bithday)
            attributes.append(att)
        }
        
        let attributesItem = ProfileViewModelPersonalInformationItem(attributes: attributes)
        items.append(attributesItem)
        
        
        if let places = profile?.favoriteplaces{
            if places.count > 1{
                let placeItem = ProfileViewModelPlaceItem(favoritePlaces: places)
                items.append(placeItem)
            }
        }
        
    }
}

