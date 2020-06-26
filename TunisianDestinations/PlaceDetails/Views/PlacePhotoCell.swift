//
//  PlacePhotoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/23/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlacePhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func  loadImg(url: String, onComplition : @escaping (UIImage) ->() ){
        
        let image = URL(string: url)!
        
        do{
            let data = try Data(contentsOf: image)
            
            //  display img when available
            onComplition(UIImage(data: data) ?? UIImage(named: "tunisia")!)
        }
        catch{
            print(" error loading image from url \(error)")
        }
    }
    
    func updateUI(imgURL: String){
        loadImg(url: imgURL) { (img) in
            self.placeImage.image = img
        }
    }
    

}
