//
//  PhotosViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/10/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewModel: NSObject{
  
    var photos = [String]()
    
}

extension PhotosViewModel: UICollectionViewDelegate{
    
}

extension PhotosViewModel: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacePhotoCell", for: indexPath) as! PlacePhotoCell
        cell.updateUI(imgURL: photos[indexPath.row])
        return cell
    }
}

extension PhotosViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}
