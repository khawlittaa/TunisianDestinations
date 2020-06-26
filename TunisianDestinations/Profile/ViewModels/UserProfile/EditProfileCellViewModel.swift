//
//  EditProfileCellViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/20/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class EditProfileCellViewModel{
    @Published var infoKey: String = ""
    @Published var infovalue: String = ""
    @Published var isEditble: Bool = false
        
    private let userattribute: ProfileInformation
    
    init(userattribute: ProfileInformation) {
        self.userattribute = userattribute
        setUpValues()
    }
    
    private func setUpValues() {
        infoKey = userattribute.infoKey!
        infovalue = userattribute.infovalue!
        isEditble = userattribute.editable ?? true
    }
    
}
