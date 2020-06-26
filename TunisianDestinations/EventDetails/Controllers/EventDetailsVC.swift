//
//  EventDetailsVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class EventDetailsVC: UIViewController {
    
    @IBOutlet weak var eventDetailsTableView: UITableView!
    
    var event = Event()
    var eventVM = EventViewModel()
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventVM.event = event
        setUpTableView()
        setUpNavController()
    }

    
    func bindViewModelToView() {
        let viewModelsValueHandler: ([EventViewModelItem]) -> Void = { [weak self] _ in
            self?.eventDetailsTableView.reloadData()
        }
        
        eventVM.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
        
        let stateValueHandler: (ListViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                print("starting loading indicator")
            case .finishedLoading:
            print("stopping loading indicator")
            case .error(let error):
            print("stopping loading indicator && show error ")
                self?.showError(error)
            }
        }
        
        eventVM.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
    private func setUpBindings() {
        bindViewModelToView()
    }
    private func setUpTableView(){
        eventDetailsTableView.dataSource = self
        eventDetailsTableView.delegate = self
        
        self.eventDetailsTableView.registerCell(nib: "EventLocationAndDatesCell", cellreuseIdentifier: "EventLocationAndDatesCell")
        self.eventDetailsTableView.registerCell(nib: "OrganizerInfoCell", cellreuseIdentifier: "OrganizerInfoCell")
        self.eventDetailsTableView.registerCell(nib: "EventDescriptionCell", cellreuseIdentifier: "EventDescriptionCell")
        self.eventDetailsTableView.registerCell(nib: "EventGeneralInfoCell", cellreuseIdentifier: "EventGeneralInfoCell")
        self.eventDetailsTableView.registerCell(nib: "PlacePhotosCell", cellreuseIdentifier: "PlacePhotosCell")
        self.eventDetailsTableView.registerCell(nib: "PlaceReviewCell", cellreuseIdentifier: "PlaceReviewCell")
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
        
        let shareaction: UIAlertAction = UIAlertAction(title: "Share Bussiness", style: .default) { action -> Void in
            self.shareTapped()
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(reviewAction)
        actionSheetController.addAction(shareaction)
        actionSheetController.addAction(cancelAction)

        actionSheetController.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
}

extension EventDetailsVC : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventVM.items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventVM.items[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventVM.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set cell xib based on cell type
        let item = eventVM.items[indexPath.section]
        switch item.type {
        case .photos:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlacePhotosCell", for: indexPath) as? PlacePhotosCell {
                cell.eventItem = item
                return cell
            }

        case .reviews:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceReviewCell", for: indexPath) as? PlaceReviewCell{
                return cell
            }
            
        case .generalInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EventGeneralInfoCell", for: indexPath) as? EventGeneralInfoCell{
                return cell
            }
            
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EventDescriptionCell", for: indexPath) as? EventDescriptionCell{
                return cell
            }
            
        case .organizerInfo:
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizerInfoCell", for: indexPath) as? OrganizerInfoCell{
            return cell
        }
            
        case .locationAndDates:
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventLocationAndDatesCell", for: indexPath) as? EventLocationAndDatesCell{
            return cell
        }
        }
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
}


