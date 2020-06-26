//
//  SignUpViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/8/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class SignUpViewModel{
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    @Published var BusinessAccount: Bool = false{
        didSet {
            if BusinessAccount == true{
                accountType = "Buisness"
            }else{
                accountType = "personal"
            }
        }
    }
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var birthDate: String = ""
    
    
    var accountType: String = "personal"
    var phone: Int = 0
    
    let validator = RegularExpressions()
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    func formatDate() -> String {
       return birthDate.StringToDate().DateToString()
    }
    
    func registerUser() {
        self.task = ApiAuthenticationClient.registerUser(firstname: firstName, lastname: lastName, userName: userName, email: email, password: password, birthDate: formatDate(), accountType: accountType)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("registred")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    print(data.message)
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
    
    lazy var validatedForm = Publishers.CombineLatest4($userName, $email, $password, $birthDate)
        .map { self.validator.isValidUserName($0) &&
            self.validator.isValidEmail($1) && self.validator.isValidPassword($2) && self.validator.isDateValid($3)}
        .eraseToAnyPublisher()
    
    lazy var validedFullName = Publishers.CombineLatest($firstName, $lastName)
        .map { self.validator.isValidNameString($0) && self.validator.isValidNameString($1)}
        .eraseToAnyPublisher()
    
    var readyToSubmit: AnyPublisher<Bool, Never>
    { return Publishers.CombineLatest(validedFullName, validatedForm)
        .map { value2, value1 in
            return value1 && value2
    }
    .eraseToAnyPublisher()
        
    }
    
}
