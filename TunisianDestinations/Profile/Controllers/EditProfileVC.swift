//
//  EditProfileVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class EditProfileVC: UIViewController {
    @IBOutlet weak var personalInfoTable: UITableView!
    
    let editVM = EditProfileViewModel()
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUptableview()
        setUpNavController()
        setUpBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        editVM.getProfileInfo()
    }
    
    func bindViewModelToView() {
        let viewModelsValueHandler: ([EditProfileCellViewModel]) -> Void = { [weak self] _ in
            self?.personalInfoTable.reloadData()
        }
        editVM.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
    }
    
    private func setUpBindings() {
        bindViewModelToView()
    }
    
    private func  setUptableview(){
        personalInfoTable.dataSource = self
        personalInfoTable.delegate = self
        personalInfoTable.registerCell(nib: "EditInformationCell", cellreuseIdentifier: "EditInformationCell")
    }
    
    private func setUpNavController(){
        let saveButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveTapped))
        self.navigationItem.rightBarButtonItem = saveButtonItem
    }
    
    
//    MARK: need to change this part latwer
    @objc func saveTapped()  {
        // call API
        editVM.updateProfileInfo()
//         self.navigationController?.popViewController(animated: true)
    }
}

// MARK:- UITableViewDelegate
extension EditProfileVC: UITableViewDelegate{
    
}

// MARK:- UITableViewDataSource
extension EditProfileVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editVM.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = personalInfoTable.dequeueReusableCell(withIdentifier: "EditInformationCell", for: indexPath) as! EditInformationCell
        cell.viewModel = editVM.items[indexPath.row]
        return cell
    }
}
