//
//  EventFilterCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class EventFilterCell: UICollectionViewCell {
    @IBOutlet weak var filterTypeLbl: UILabel!
    
    var item: EventFilterTypeViewModelItem? {
         didSet {
          filterTypeLbl.text = item?.FilterTitle ?? "Filter"
            if  item?.isSelected == true {
                selectedLblLayout()
            }
         }
      }
    
    func selectedLblLayout(){
        filterTypeLbl.backgroundColor = UIColor(named: "lightBlue")
        filterTypeLbl.textColor = UIColor.white
        filterTypeLbl.layer.cornerRadius = 6
        filterTypeLbl.layer.masksToBounds = true
    }
}
