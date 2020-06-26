//
//  LoginViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/8/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel{
    
    @Published var identifier: String = ""
    @Published var password: String = ""
    
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    private var disposables: Set<AnyCancellable> = []
    let validator = RegularExpressions()
    
    var  task :  AnyCancellable?  =  nil
    var userCrendentials: UserCredentials?{
        didSet {
            print("token is \(userCrendentials?.token)")
        }
    }
    
    
    func loginUser() {
        self.task = ApiAuthenticationClient.logInUser(userName: identifier, password: password)  .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("logged in")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    self.userCrendentials = data
                    UserDefaults.standard.set(data.token, forKey: "token")
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
    lazy var validatedCredentials = Publishers.CombineLatest($identifier, $password)
        .map {self.validator.isValidUserName($0) && self.validator.isValidPassword($1) }
        .eraseToAnyPublisher()
    
    // need a publisher for each value here
    lazy var validatedUsername = Publishers.CombineLatest($identifier, $identifier)
        .map {self.validator.isValidUserName($0) && self.validator.isValidUserName($1) }
        .eraseToAnyPublisher()
    
    lazy var validatedPassword = Publishers.CombineLatest($password, $password)
        .map {self.validator.isValidPassword($0) && self.validator.isValidPassword($1) }
        .eraseToAnyPublisher()
    
  
    
}
