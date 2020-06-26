//
//  EditPasswordVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/4/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class EditPasswordVC: UIViewController {
    
    @IBOutlet weak var oldPswTextField: UITextField!
    @IBOutlet weak var newPswTextField: UITextField!
    @IBOutlet weak var confirmPswTextField: UITextField!
    
    @IBOutlet weak var updatePswBtn: UIButton!
    
    let passwordVM = UpdatePasswordViewModel()
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnAppearance()
        setUpBindings()
    }
    
    func setBtnAppearance(){
        updatePswBtn.layer.cornerRadius = 15
    }
    
    func bindViewToViewModel() {
        oldPswTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.oldPassword, on: passwordVM)
            .store(in: &bindings)
        
        newPswTextField.textChangePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.newPassword, on: passwordVM)
            .store(in: &bindings)
        
        confirmPswTextField.textChangePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.confirmedPassword, on: passwordVM)
            .store(in: &bindings)
    }
    
    func bindViewModelToView() {
        
        // btn enabled when everything is good pasw match and verify regEx
        passwordVM.validatedPasswords
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: updatePswBtn)
            .store(in: &bindings)
    }
    
    func setUpBindings(){
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @IBAction func updatePswBtnClicked(_ sender: Any) {
        // api call here
        passwordVM.updatePassword()
//        self.navigationController?.popViewController(animated: false)
    }
    
    
}
