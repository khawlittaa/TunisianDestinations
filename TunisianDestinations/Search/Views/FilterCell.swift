//
//  FilterCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    @IBOutlet weak var filterTypeLbl: UILabel!
    
    var item: SearchFilterTypeViewModelItem? {
       didSet {
        filterTypeLbl.text = item?.FilterTitle ?? "Filter"
       }
    }
}
