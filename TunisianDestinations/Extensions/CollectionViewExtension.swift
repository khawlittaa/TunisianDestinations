//
//  CollectionViewExtension.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/10/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    
    func registerCell(nib: String, cellreuseIdentifier: String) {
         let cell = UINib(nibName: nib, bundle: nil)
        self.register(cell, forCellWithReuseIdentifier: cellreuseIdentifier)
     }
}
