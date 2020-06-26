//
//  EditFieldVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/4/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class EditFieldVC: UIViewController {
    
    @IBOutlet weak var fieldValueTxtField: UITextField!
    @IBOutlet weak var fieldNameLbl: UILabel!
    
    @IBOutlet weak var updateInfoBtn: UIButton!
    
    
    var item: SettingsViewModelItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnAppearance()
        SetUpValues()
    }
  
    func setBtnAppearance(){
        updateInfoBtn.layer.cornerRadius = 15
    }
    
    func SetUpValues(){
        guard let item = item as? EditFieldSettingViewModelItem  else {
            return
        }
        guard let key = item.attribute.infoKey , let value = item.attribute.infovalue else {
            return
        }
        self.updateInfoBtn.setTitle("Update your \(key)", for: .normal)
        self.fieldNameLbl.text = key
        self.fieldValueTxtField.text = value
    }
    
    @IBAction func updateInfoBtnClicked(_ sender: Any) {
        // api call here
        guard let item = item as? EditFieldSettingViewModelItem  else {
                  return
              }
        if (item.isEmail){
            item.updateEmail(email: self.fieldValueTxtField.text!)
        }
        self.navigationController?.popViewController(animated: false)
    }
    
}
