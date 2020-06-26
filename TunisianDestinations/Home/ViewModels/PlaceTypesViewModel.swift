//
//  PlaceTypesViewmodel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/23/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine
import UIKit

class PlaceTypesViewModel: NSObject {
  @Published   var types: [PlaceSubCategory] = []
    // get types from Api
}

//MARK:- UICollectionViewDataSource
extension PlaceTypesViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.placeSubCategory = types[indexPath.row]
//        cell.updateUI(placeType: )
        return cell
    }
}
