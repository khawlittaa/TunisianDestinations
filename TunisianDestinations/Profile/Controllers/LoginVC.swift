//
//  LoginVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/7/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine
import Reachability

class LoginVC: UIViewController {
    
    @IBOutlet weak var RegisterNowBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var userNameErrorLbl: UILabel!
    
    var loginVM = LoginViewModel()
    private var bindings = Set<AnyCancellable>()
    
    private var  reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! reachability = Reachability()
        setBtnAppearance()
        setUpTargets()
        setUpBindings()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // adding Network reachability notifier to listen to networkStatus changees
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func setBtnAppearance(){
        LoginBtn.layer.cornerRadius = 15
    }
    
    private func setUpTargets() {
        self.LoginBtn.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        self.RegisterNowBtn.addTarget(self, action: #selector(onClickregisterNowBtn), for: .touchUpInside)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
            self.presentAlert(withTitle: "No Internet Connection", message: "Make sure your device is connected to the internet.", actions: ["OK" : .default] , completionHandler: nil)
        case .none:
            print("None")
        }
    }
    
    @objc private func onClick() {
        loginVM.loginUser()
        let profile = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "UserProfileVC")
        navigationController?.pushViewController(profile, animated: false)
        //        navigationController?.popViewController(animated: false)
    }
    
    @objc private func onClickregisterNowBtn() {
        let signUp = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "SignUp")
        navigationController?.pushViewController(signUp, animated: false)
    }
    func bindViewToViewModel() {
        userNameTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.identifier, on: loginVM)
            .store(in: &bindings)
        
        passwordTextField.textChangePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: loginVM)
            .store(in: &bindings)
    }
    
    func bindViewModelToView() {
        loginVM.validatedCredentials
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: LoginBtn)
            .store(in: &bindings)
        
        loginVM.validatedPassword
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: passwordErrorLbl)
            .store(in: &bindings)
        
        loginVM.validatedUsername
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: userNameErrorLbl)
            .store(in: &bindings)
    }
    
    
    private func setUpBindings() {
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @IBAction func exitBtnClicked(_ sender: Any) {
        self.presentAlertWithCancelAction(withTitle: "Are you Sure ?", message: "if you procceed.You will lose all personal data")
    }
    
}
