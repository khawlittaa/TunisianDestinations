//
//  SignUpVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/7/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine
import Reachability

class SignUpVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUPBtn: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameErrorLbl: UILabel!
    @IBOutlet weak var lastNameErrorLbl: UILabel!
    @IBOutlet weak var userNameErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var birthDateErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    
    @IBOutlet weak var businessAcountSwitch: UISwitch!
    
    let signUpVM = SignUpViewModel()
    private var bindings = Set<AnyCancellable>()
    
    private var  reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! reachability = Reachability()
        setUpBtn()
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
    
    @objc func tapDone() {
        if let datePicker = self.birthdayTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "yyyy/MM/dd"
            
            let formattedDate =  dateformatter.string(from: datePicker.date)
            self.birthdayTextField.text = formattedDate
        }
        self.birthdayTextField.resignFirstResponder()
    }
    
    @objc private func onBusinessSwitchTouch() {
        signUpVM.BusinessAccount = businessAcountSwitch.isOn
    }
    @objc private func onClicksignUpBtn() {
        signUpVM.registerUser()
//        navigationController?.popViewController(animated: false)
    }
    
    @objc private func onClicklogInBtn() {
        let login = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "Login")
        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(login, animated: false)
    }
    func setUpBtn(){
        signUPBtn.layer.cornerRadius = 15
    }
    
    private func setUpTargets() {
        birthdayTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        signUPBtn.addTarget(self, action: #selector(onClicksignUpBtn), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(onClicklogInBtn), for: .touchUpInside)
        businessAcountSwitch.addTarget(self, action: #selector(onBusinessSwitchTouch), for: .allTouchEvents)
    }

    func bindViewToViewModel() {
        firstNameTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.firstName, on: signUpVM)
            .store(in: &bindings)
        
        lastNameTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.lastName, on: signUpVM)
            .store(in: &bindings)
        
        userNameTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.userName, on: signUpVM)
            .store(in: &bindings)
        
        passwordTextField.textChangePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: signUpVM)
            .store(in: &bindings)
        
        emailTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.email, on: signUpVM)
            .store(in: &bindings)
        
        birthdayTextField.textEndEditingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.birthDate, on: signUpVM)
            .store(in: &bindings)
        
    }
    
    /// <#Description#>
    func bindViewModelToView() {
        signUpVM.readyToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: signUPBtn)
            .store(in: &bindings)
        
        signUpVM.validedFullName
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: firstNameErrorLbl)
            .store(in: &bindings)
        
        signUpVM.validedFullName
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: lastNameErrorLbl)
            .store(in: &bindings)
        
        signUpVM.validatedForm
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: emailErrorLbl)
            .store(in: &bindings)
        
        signUpVM.validatedForm
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: userNameErrorLbl)
            .store(in: &bindings)
        
        signUpVM.validatedForm
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: passwordErrorLbl)
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
