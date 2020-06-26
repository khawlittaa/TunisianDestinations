//
//  SettingsVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine
class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    let SettingsVM = SettingsViewModel()
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUptableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setUptableView(){
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.registerCell(nib: "SettingFieldCell", cellreuseIdentifier: "SettingFieldCell")
        
        settingsTableView.registerCell(nib: "SettingDeleteCell", cellreuseIdentifier: "SettingDeleteCell")
        
    }
    func bindViewModelToView() {
        
        let viewModelsValueHandler: ([SettingsViewModelItem]?) -> Void = { [weak self] _ in
            self?.settingsTableView.reloadData()
        }
        
        SettingsVM.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
    }
    
    private func setUpBindings() {
        bindViewModelToView()
    }
    
    func deleteActivityAlert(withTitle title: String, message : String, index: Int){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { action in
            //                  self.navigationController?.popViewController(animated: false)
            print("Remove")
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in
            self.navigationController?.popViewController(animated: false)
            // api call here

            let id: Int = UserDefaults.standard.integer(forKey: "id")
            let item =  self.SettingsVM.items[index] as! DeleteSettingViewModelItem
            item.delete(id: id)
            print("Remove")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsVC : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsVM.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsVM.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set cell xib based on cell type
        let item = SettingsVM.items[indexPath.section]
        switch item.type {
        case .edit:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingFieldCell", for: indexPath) as? SettingFieldCell {
                cell.item = item
                return cell
            }
        case .delete:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingDeleteCell", for: indexPath) as? SettingDeleteCell {
                cell.item = item
                return cell
            }
        }
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = SettingsVM.items[indexPath.section]
        switch item.type {
        case .edit:
            guard let item = item as? EditFieldSettingViewModelItem  else {
                return
            }
            if item.isEmail {
                let editVC = self.getVCfromStoryboard(storyboard: "Settings", VCIdentifier: "EditFieldVC") as! EditFieldVC
                editVC.item = item 
                self.navigationController?.pushViewController(editVC, animated: false)
            }
            else{
                let editVC = self.getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "EditProfileVC") as! EditProfileVC
                //        edit.editVM.user = userProfileVM.profile!
                self.navigationController?.pushViewController(editVC, animated: false)
            }
        case .delete:
            
            guard let item = item as? DeleteSettingViewModelItem  else {
                return
            }
            if item.isPassword {
                /// get profile from WS
                let edit = getVCfromStoryboard(storyboard: "Settings", VCIdentifier: "EditPasswordVC") as! EditPasswordVC
                //                edit.editVM.user = userProfileVM.profile!
                self.navigationController?.pushViewController(edit, animated: false)
            }else{
                deleteActivityAlert(withTitle: "Are you sure ?", message: " Do you really want to \(item.settingMessage)? all your account data will be permanetly  deleted ",index: indexPath.section)
            }
        }
    }
    
}

