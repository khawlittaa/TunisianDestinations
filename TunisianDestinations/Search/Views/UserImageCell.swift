//
//  UserImageCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class UserImageCell: UICollectionViewCell {
    @IBOutlet weak var selectedImage: UIImageView!
    
    var index:Int?
    var reviewVM: ReviewViewModel?
    
    func SetImmage(image: UIImage){
        selectedImage.image = image
    }
    
    func setAttributes(index: Int, reviewVM: ReviewViewModel ){
        self.index = index
        self.reviewVM = reviewVM
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        self.reviewVM?.reviewImages.remove(at: index!)
    }
}
