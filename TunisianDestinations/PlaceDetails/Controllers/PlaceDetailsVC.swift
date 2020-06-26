//
//  PlaceDetailsVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlaceDetailsVC: UIViewController {
    
    @IBOutlet weak var placedetailsTableView: UITableView!
    
    var place = Place(id: "", name: "", type: "")
    var placeViewModel = PlaceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeViewModel.place = place
        setUpTableView()
        setUpNavController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MapVC.pinPlace(place: place)
    }
    
    private func setUpTableView(){
        
        placedetailsTableView.dataSource = placeViewModel
        placedetailsTableView.delegate = placeViewModel
        
        self.placedetailsTableView.registerCell(nib: "PlaceBasicInfoCell", cellreuseIdentifier: "PlaceBasicInfoCell")
        self.placedetailsTableView.registerCell(nib: "PlaceContactInfoCell", cellreuseIdentifier: "PlaceContactInfoCell")
        self.placedetailsTableView.registerCell(nib: "OperationHoursCell", cellreuseIdentifier: "OperationHoursCell")
        self.placedetailsTableView.registerCell(nib: "PlaceLocationCell", cellreuseIdentifier: "PlaceLocationCell")
        self.placedetailsTableView.registerCell(nib: "PlacePhotosCell", cellreuseIdentifier: "PlacePhotosCell")
        self.placedetailsTableView.registerCell(nib: "PlaceReviewCell", cellreuseIdentifier: "PlaceReviewCell")
    }
    
    private func setUpNavController(){
        let shareButtonItem = UIBarButtonItem(image: UIImage(named: "share_icon"), style: .plain, target: self, action: #selector(shareTapped))
        
        let moreButtonItem = UIBarButtonItem(image: UIImage(named: "more_icon"), style: .plain, target: self, action: #selector(moreInfoTapped))
        self.navigationItem.rightBarButtonItems = [shareButtonItem,moreButtonItem]
    }
    
    @objc func shareTapped()  {
           let textToShare = "This Place is Awsome! Check out the reviews of it!"
           if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
               let objectsToShare: [Any] = [textToShare, myWebsite]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
               self.present(activityVC, animated: true, completion: nil)
           }
    }
    
    @objc func moreInfoTapped() {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let reviewAction: UIAlertAction = UIAlertAction(title: "Add Review", style: .default) { action -> Void in
            let review = self.getVCfromStoryboard(storyboard: "Events", VCIdentifier: "ReviewVC")
            self.navigationController?.pushViewController(review, animated: false)
        }

        let saveAction: UIAlertAction = UIAlertAction(title: "Add to Favorites", style: .default) { action -> Void in
//            API CAll here
            self.placeViewModel.addToFavorites()
            print("Adding place to favorite List")
        }
        let shareaction: UIAlertAction = UIAlertAction(title: "Share Bussiness", style: .default) { action -> Void in
            self.shareTapped()
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(reviewAction)
        actionSheetController.addAction(saveAction)
        actionSheetController.addAction(shareaction)
        actionSheetController.addAction(cancelAction)


        // present an actionSheet...
        // present(actionSheetController, animated: true, completion: nil)   // doesn't work for iPad

        actionSheetController.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
}
