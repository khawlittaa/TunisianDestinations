//
//  TableViewExtension.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/10/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell(nib: String, cellreuseIdentifier: String) {
        let  basicInfoCell = UINib(nibName: nib, bundle: nil)
        self.register(basicInfoCell, forCellReuseIdentifier: cellreuseIdentifier)
    }
    
    func registerHeaderFooter(nib: String, HeaderFooterreuseIdentifier: String){
        let headerNib = UINib.init(nibName: nib, bundle: nil)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: HeaderFooterreuseIdentifier)
    }
}
