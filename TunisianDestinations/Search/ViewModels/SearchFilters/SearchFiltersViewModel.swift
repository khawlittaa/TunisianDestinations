//
//  SearchFiltersViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class SearchFiltersViewModel: NSObject{
    var items = [SearchFilterTypeViewModelItem]()
    let searchVM = SearchViewModel()

    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        let distanceItem = SearchFilterViewModelDisttanceItem()
        items.append(distanceItem)
        let openItem = SearchFilterViewModelOpenNowItem()
        items.append(openItem)
        let categoryItem = SearchFilterViewModelCategoryItem()
        categoryItem.onAppear()
        items.append(categoryItem)
    }
    
    func filterByDistance(distanceFromMe: Double, places: [Place]?) -> [Place]?{
        let places = places?.filter({(place: Place) -> Bool in

            let locA = CLLocation(latitude: place.placeLocation!.lattitude, longitude: place.placeLocation!.longitude)

            let currentLoc = locationManager.location
            let distanceMeters = locA.distance(from: currentLoc!)
            print("--------------------distance from me is :\(distanceMeters / 1000.0) Km")
            return distanceMeters <= distanceFromMe
               })
               return places
    }
    func filterbyCategory(categoryName: String, places: [Place]?) -> [Place]?{
        let places = places?.filter({(place: Place) -> Bool in
            return place.placeType == categoryName
        })
        return places
    }
    
    func filterByPriceRange(priceRange: Int, places: [Place]?) -> [Place]?{
        let places = places?.filter({(place: Place) -> Bool in
            return place.priceLevel == priceRange
        })
        return places
    }
    
    func filterByStarRating(rating: Float, places: [Place]?) -> [Place]? {
        let places = places?.filter({(place: Place) -> Bool in
            return place.rating == rating
        })
        return places
    }
    
    func openNowFilter(places: [Place]?) -> [Place]?{
      let places = places?.filter({(place: Place) -> Bool in
              return place.isOpen == true
          })
          return places
    }
    
}

extension SearchFiltersViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.item = items[indexPath.row]
        return cell
    }
}
