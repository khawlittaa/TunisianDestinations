//
//  UserProfileVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class UserProfileVC: UIViewController {
    
    @IBOutlet weak var userProfileTable: UITableView!
    
    let userProfileVM = UserProfileViewModel()
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavController()
        setUpTableView()
        setUpBindings()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userProfileVM.onAppear()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func bindViewModelToView() {
        let viewModelsValueHandler: ([CustomViewModelItem]) -> Void = { [weak self] _ in
            self?.userProfileTable.reloadData()
        }
        
        userProfileVM.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
    }
    
    private func setUpBindings() {
        bindViewModelToView()
    }
    
    private func setUpTableView(){
        userProfileTable.dataSource = self
        userProfileTable.delegate = self
        
        userProfileTable.registerCell(nib: "PersonalInfoCell", cellreuseIdentifier: "PersonalInfoCell")
        userProfileTable.registerCell(nib: "NameandPictureCell", cellreuseIdentifier: "NameandPictureCell")
        userProfileTable.registerCell(nib: "GeneralInfoCell", cellreuseIdentifier: "GeneralInfoCell")
        userProfileTable.registerCell(nib: "PlaceReviewCell", cellreuseIdentifier: "PlaceReviewCell")
        
        userProfileTable.reloadData()
    }
    
    private func setUpNavController(){
        let logoutButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logoutTapped))
        
        let editButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItems = [logoutButtonItem,editButtonItem]

        
//        self.navigationItem.rightBarButtonItems = [logoutButtonItem]
    }
    
    @objc func editTapped()  {
         let edit = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "EditProfileVC") as! EditProfileVC
         edit.editVM.user = userProfileVM.profile!
         self.navigationController?.pushViewController(edit, animated: true)
     }

    @objc func logoutTapped()  {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "id")

        navigationController?.popViewController(animated: false)
    }
    
}

extension UserProfileVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return userProfileVM.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfileVM.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userProfileVM.items[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = userProfileVM.items[indexPath.section]
        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NameandPictureCell", for: indexPath) as? NameandPictureCell{
                cell.cameraHandeler = self
                cell.item = item
                return cell
            }
        case .personalInformation:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoCell", for: indexPath) as? PersonalInfoCell{
                cell.item = userProfileVM.attributes[indexPath.row]
                return cell
            }
            
        case .activity:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceReviewCell", for: indexPath) as? PlaceReviewCell{
                //        cell.item = item
                return cell
            }
        case .favoritePlaces:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralInfoCell", for: indexPath) as? GeneralInfoCell{
                cell.updateUI(place: userProfileVM.places[indexPath.row])
                return cell
            }
        case .favoriteEvents:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralInfoCell", for: indexPath) as? GeneralInfoCell{
                //        cell.item = item
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

extension UserProfileVC: UITableViewDelegate{
    
}
