//
//  NameandPictureCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class NameandPictureCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImageBtn: UIButton!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    
    var cameraHandeler: UIViewController?
    
    var item: CustomViewModelItem? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? ProfileViewModelNameAndPictureItem  else {
                return
            }
            userNameLbl?.text = item.userName
            fullNameLbl.text = item.fullName
            guard let userImg = item.pictureUrl  else {
                return
            }
            //            let profileImg = UIImage(named: userImg)
            loadImg(url: userImg) { (img) in
                self.userProfileImageBtn?.setImage(img, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpBtnAperance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func  loadImg(url: String, onComplition : @escaping (UIImage) ->() )
    {
        
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
    
    
    private func setUpBtnAperance(){
        userProfileImageBtn.layer.masksToBounds = true
        userProfileImageBtn.layer.cornerRadius = userProfileImageBtn.frame.width/2
        userProfileImageBtn.imageView?.contentMode = .scaleAspectFill
        userProfileImageBtn.clipsToBounds = true
    }
    
    //MARK:- upload selected image to server
    @IBAction func profilePicBtnClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: cameraHandeler!)
        CameraHandler.shared.imagePickedBlock = { (image) in
            
            let imgData = image.jpegData(compressionQuality: 0.1)
            guard let item = self.item as? ProfileViewModelNameAndPictureItem  else {
                return
            }
            item.imgData = imgData
            item.uploadPhoto(imgData!, params: nil, completion: { (user) in
                print("uploaded")
            })
            self.userProfileImageBtn.setImage(image, for: .normal)
        }
    }
    
    
}

