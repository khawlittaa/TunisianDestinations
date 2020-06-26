//
//  ReviewVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import DKImagePickerController
import Photos
import UIKit
import Cosmos
import Combine

class ReviewVC: UIViewController {
    
    @IBOutlet weak var selectedRatingText: UITextField!
    @IBOutlet weak var selectRatingLbl: UILabel!
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var selectedImagesCollectionView: UICollectionView!
    @IBOutlet weak var userReviewTxtView: UITextView!
    @IBOutlet weak var userRating: CosmosView!
    
    private var bindings = Set<AnyCancellable>()
    
    private lazy var imageManager = PHCachingImageManager()
    
    let reviewVM = ReviewViewModel()
    var imagesList = [DKAsset]()
    var selectedImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionview()
        setUpAppearances()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func setUpCollectionview(){
        selectedImagesCollectionView.dataSource = self
    }
    
    func setUpAppearances(){
        submitBtn.layer.cornerRadius = 15
        userReviewTxtView.placeholder = "How was your experience ?"
    }
    
    func bindViewToViewModel() {
        userReviewTxtView.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.reviewText, on: reviewVM)
            .store(in: &bindings)
        
    }
    
    func bindCosmosview(){
        
        // need to bbind label to cosms view
        userRating.didFinishTouchingCosmos = { rating in
            print("selected raring\(rating)")
            self.selectedRatingText.text = String(rating)
            
            self.selectedRatingText.textEndEditingPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.starRatingValue, on: self.reviewVM)
                .store(in: &self.bindings)
            
            self.reviewVM.validatedReviewStars
                .receive(on: RunLoop.main)
                .assign(to: \.isHidden, on:self.selectRatingLbl )
                .store(in: &self.bindings)
        }
    }
    
    func bindViewModelToView() {
        reviewVM.validatedReviewText
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: submitBtn)
            .store(in: &bindings)
        
        let viewModelsValueHandler: ([UIImage]) -> Void = { [weak self] _ in
            self?.selectedImagesCollectionView.reloadData()
        }
        reviewVM.$reviewImages
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
        
    }
    
    private func setUpBindings() {
        bindViewToViewModel()
        bindViewModelToView()
        bindCosmosview()
    }
    
    func multipleImages(){
        let pickerController = DKImagePickerController()
        /// Forces selection of tapped image immediatly.
        pickerController.singleSelect = false
        /// The maximum count of assets which the user will be able to select.
        pickerController.maxSelectableCount = 10
        pickerController.sourceType = .both
        pickerController.assetType = .allPhotos
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for asset in assets {
                
                print("didSelectAssets")
                self.imagesList.append(asset)
                asset.fetchOriginalImage(completeBlock: ({ (image, info) in
                    
                    guard let imageData = image!.jpegData(compressionQuality: 0) else {
                        print("There is no image bro..!")
                        return
                    }
                    let thumbnails = UIImage(data: imageData)
                    let reziedImg = self.resizeImage(image: thumbnails!, newWidth: 200)
                    self.reviewVM.reviewImages.append(reziedImg!)
                    print("selected image 3333333 \(image)! and resized image \(reziedImg)")
                    self.selectedImagesCollectionView.reloadData()
                }))
                
            }
            
        }
        self.present(pickerController, animated: true) {}
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func addImagebtnPressed(_ sender: Any) {
        multipleImages()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.presentAlertWithCancelAction(withTitle: "", message: "Hold up! you haven't posted your review yet. If you leave Now your review will be removed")
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewVM.reviewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserImageCell", for: indexPath) as! UserImageCell
        cell.SetImmage(image: (reviewVM.reviewImages[indexPath.row]))
        cell.setAttributes(index: indexPath.row, reviewVM: reviewVM)
        return cell
    }
}
