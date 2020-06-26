//
//  CategoryCell.swift
//  Tounsi
//
//  Created by khaoula hafsia on 2/18/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImag: UIImageView!
    @IBOutlet weak var categoryNamelbl: UILabel!
    
    var placeSubCategory: PlaceSubCategory?{
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImgDisplay()
//        self.categoryNamelbl.lineBreakMode = .byWordWrapping
    }
    
    func setImgDisplay(){
        categoryImag.clipsToBounds = true
        categoryImag.layer.cornerRadius = 10
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
    
    func updateUI(){
        self.categoryNamelbl.text = placeSubCategory?.placeSubCategoryName
        
        loadImg(url: (placeSubCategory?.placeSubCategoryImageURI!)!) { (img) in
            self.categoryImag.image = img
        }
    }
}
