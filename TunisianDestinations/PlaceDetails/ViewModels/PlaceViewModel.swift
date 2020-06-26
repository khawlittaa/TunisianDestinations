//
//  PlaceViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Combine
import Foundation
import  UIKit
import GooglePlaces

class  PlaceViewModel: NSObject {
    
    var items = [PlaceViewModelItem]()
    var place: Place? {
        
        didSet {
            // init each PlaceVM type item with needed values here and append items
            if let location = place?.placeLocation {
                let placeLocation = PlaceViewModelLocationItem(address: location.formattedAddress)
                items.append(placeLocation)
            }
            
            if let name = place?.placeName, let type = place?.placeType
            {
                let generalInfo = PlaceViewModelBasicInfoItem(placeName: name, placeType: type, placeRating: 0, userRatingTotal: 0)
                items.append(generalInfo)
            }
            
            if let phone = place?.phoneNumber, let web = place?.website {
                let contactInfo = PlaceViewModelContactInfoItem(phone: phone, website: web)
                items.append(contactInfo)
            }
            
            if let times = place?.openingHours{
                let opTimes = PlaceViewModelOperationhoursItem(operatingHours: times)
                items.append(opTimes)
                
            }
            
            if let photos = place?.pictures {
                let photos = PlaceViewModelPhotosItem(images: photos)
                items.append(photos)
                let review = PlaceViewModelReviewItem()
                items.append(review)
            }
            
        }
    }
    
    var  task :  AnyCancellable?  =  nil
    
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    let userID: Int = UserDefaults.standard.value(forKey: "id") as! Int
//    let userID: Int = 4
    func addToFavorites(){
        self.task = ApiPlacesClient.addPlaceToFavorite(adress: (place?.placeLocation!.formattedAddress)!, googleplaceID: (place?.placeID)!, userID: userID, lat: (place?.placeLocation!.lattitude)!, long: (place?.placeLocation!.longitude)!, placeName: place!.placeName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Adding place to favorite List ")
                case let .failure(error):
                    print(error)
                    self.errorCode = error.localizedDescription
                    self.showAlert = true
                }
            },
                  receiveValue: { data in
                    //                self.fillProfile()
                    self.errorCode = ""
                    self.showAlert = false
            })
    }
}

extension PlaceViewModel : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set cell xib based on cell type
        let item = items[indexPath.section]
        switch item.type {
        case .basicInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceBasicInfoCell", for: indexPath) as? PlaceBasicInfoCell {
                cell.item = item
                return cell
            }
        case .contactInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceContactInfoCell", for: indexPath) as? PlaceContactInfoCell {
                cell.item = item
                return cell
            }
        case .location:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceLocationCell", for: indexPath) as? PlaceLocationCell {
                cell.item = item
                return cell
            }
            
        case .photo:
            //PlacePhotosCell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlacePhotosCell", for: indexPath) as? PlacePhotosCell {
                cell.item = item
                return cell
            }
            
        case .review:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceReviewCell", for: indexPath) as? PlaceReviewCell{
                return cell
            }
            
        case .operationHours:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OperationHoursCell", for: indexPath) as? OperationHoursCell {
                //   item.rowCount = place?.openingHours?.count ?? 1
                cell.item = place?.openingHours?[indexPath.row]
                return cell
            }
        }
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
}
