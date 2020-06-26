//
//  PlacePhotosCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/10/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlacePhotosCell: UITableViewCell {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    let photosVM = PhotosViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photosCollectionView.dataSource = photosVM
        photosCollectionView.delegate = photosVM
        
        photosCollectionView.registerCell(nib: "PlacePhotoCell", cellreuseIdentifier: "PlacePhotoCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: PlaceViewModelItem? {
         didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? PlaceViewModelPhotosItem  else {
               return
            }
            //set UI elements
            photosVM.photos = item.images
           //  addressLbl.text = item.address
         }
    }
    
    var eventItem: EventViewModelItem? {
          didSet {
             // cast the ProfileViewModelItem to appropriate item type
             guard let eventItem = eventItem as? EventViewModelPhotosItem  else {
                return
             }
             //set UI elements
             photosVM.photos = eventItem.images
          }
     }
    
}
