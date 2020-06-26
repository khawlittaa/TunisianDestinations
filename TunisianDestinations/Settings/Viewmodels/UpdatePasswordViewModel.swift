//
//  UpdatePasswordViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/4/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class UpdatePasswordViewModel{
    
    
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmedPassword: String = ""
    
    let validator = RegularExpressions()
    
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    // valitator for matching new psws
    // validator for true old psw
    
    
  lazy var  verifyPasswordEquqlity = Publishers.CombineLatest( $newPassword,$confirmedPassword)
    .map {self.ispassworEqual(newpsw: $0, vonfirmedpsw: $1)}
        .eraseToAnyPublisher()
    
    func ispassworEqual(newpsw: String,vonfirmedpsw: String) -> Bool{
        return newpsw == vonfirmedpsw
    }
    
  lazy var validatedPasswords = Publishers.CombineLatest3($oldPassword, $newPassword,$confirmedPassword)
        .map {self.validator.isValidPassword($0) && self.validator.isValidPassword($1) && self.validator.isValidPassword($2)
            && self.ispassworEqual(newpsw: $1,vonfirmedpsw: $2)}
        .eraseToAnyPublisher()
    
    
    func updatePassword() {
        self.task = ApiProfileClient.UpdatePassword(oldpassword: oldPassword, newPassword: newPassword)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("pasword changes ")
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
