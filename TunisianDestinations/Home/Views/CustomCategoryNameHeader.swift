//
//  CustomCategoryNameHeader.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class CustomCategoryNameHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var categoryNameLabel: UILabel!

    func setCategryName(category: String){
        categoryNameLabel.text = category
    }
}
