//
//  EditInformationCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class EditInformationCell: UITableViewCell {
    
    @IBOutlet weak var userInformationValueLbl: UITextField!
    @IBOutlet weak var userInformationKeyLbl: UILabel!
    
    private var bindings = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var viewModel: EditProfileCellViewModel! {
        didSet {
            setUpViewModel()
            bindViewToViewModel()
            setKeyboardType()
        }
    }
    
    private func setUpViewModel() {
        userInformationKeyLbl.text = viewModel.infoKey
        userInformationValueLbl?.text = viewModel.infovalue
        userInformationValueLbl.isEnabled = viewModel.isEditble
    }
    
    
    func bindViewToViewModel() {
        userInformationValueLbl.textChangePublisher
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .assign(to: \.infovalue, on: viewModel)
            .store(in: &bindings)
    }
    
    @objc func tapDone() {
        if let datePicker = self.userInformationValueLbl.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "yyyy/MM/dd"
            
            let formattedDate =  dateformatter.string(from: datePicker.date)
            self.userInformationValueLbl.text = formattedDate
        }
        self.userInformationValueLbl.resignFirstResponder()
    }
    
    func setKeyboardType(){
        if userInformationKeyLbl.text == "Phone Number"{
            userInformationValueLbl.keyboardType = .numberPad
        }else{
            if userInformationKeyLbl.text == "Date of Birth"{
                userInformationValueLbl.setInputViewDatePicker(target: self, selector: #selector(tapDone))
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
