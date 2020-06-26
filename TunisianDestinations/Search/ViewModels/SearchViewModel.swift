//
//  SearchViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import Combine

class SearchViewModel{
    
    @Published  var  searchResultPlaces:[Place]?{
        didSet{ print ("searchResultPlaces did set ")}
    }
    @Published  var searchString: String = ""
    @Published  var searchLocation: String = ""
    
    var token: GMSAutocompleteSessionToken?
    var  placesClient: GMSPlacesClient?
    let filter = GMSAutocompleteFilter()
    var viewType: SearchViewType
    
    
    
    init() {
        GMSServices.provideAPIKey(Constants.GooglePlacesAPIKey)
        GMSPlacesClient.provideAPIKey(Constants.GooglePlacesAPIKey)
        /**
         * Create a new session token. Be sure to use the same token for calling
         * findAutocompletePredictions, as well as the subsequent place details request.
         * This ensures that the user's query and selection are billed as a single session.
         */
        token = GMSAutocompleteSessionToken.init()
        //always search in Tunisia Only
        filter.countries = ["TN"]
        searchResultPlaces = [Place]()
        viewType = .list
        
    }
    
    func changeViewType(){
        if viewType == .map{
            viewType = .list
        }else {
            viewType = .map
        }
    }
    
    func searchPlaceByAddress(name: String, address: String, coord: CLLocationCoordinate2D){
        // Create a type filter.
        filter.type = .establishment
        placesClient = GMSPlacesClient.init()
        let seachString = "\(name) near \(address)"
        let bounds = GMSCoordinateBounds(coordinate: coord, coordinate: coord)
        searchResultPlaces = [Place]()
        
        placesClient?.findAutocompletePredictions(fromQuery: seachString, bounds: bounds, boundsMode: GMSAutocompleteBoundsMode.restrict, filter: filter, sessionToken: token, callback: { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error)")
                return
            }
            if let results = results {
                for result in results {
                    
                    let id = result.placeID
                    
                    let place =  self.getPlaceByID(id: id)
                    self.searchResultPlaces?.append(place)
                    
                }
            }
        })
    }
    
    func searchPlacesByName(name: String) -> [Place]{
        // Create a type filter.
        filter.type = .establishment
        placesClient = GMSPlacesClient.init()
        
        searchResultPlaces = [Place]()
        
        guard  let visibleRegion = MapVC.getVisibleRegion() else {
            // pop up you must allow maps to be able to finish this
            //MARK: DELETE AFTER TEST
            var place = Place(id: "ChIJzckin3d1AhMRnbjhn1jz3bs", name: "Test Palce", type: "cafe")
            let location = Location(id: "ChIJzckin3d1AhMRnbjhn1jz3bs", adress: "somewhere adresse", long: 10.863889, latt: 38.188910)
            place.setLocation(location: location)
            searchResultPlaces?.append(place)
            place = Place(id: "ChIJzckin3d1AhMRnbjhn1jz3bs4444", name: "Test Palce", type: "cafe")
            let location2 = Location(id: "ChIJzckin3d1AhMRnbjhn1jz3bs", adress: "somewhere  other adresse", long: 11.263889, latt: 36.188910)
            place.placeLocation = location2
            searchResultPlaces?.append(place)
            return searchResultPlaces!
            //            return  [Place]()
        }
        let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
        
        placesClient?.findAutocompletePredictions(fromQuery: name, bounds: bounds, boundsMode: GMSAutocompleteBoundsMode.restrict, filter: filter, sessionToken: token, callback: { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error)")
                
                let place =  self.getPlaceByID(id: "id")
                self.searchResultPlaces?.append(place)
                self.searchResultPlaces?.append(place)
                return
            }
            if let results = results {
                for result in results {
                    let id = result.placeID
                    let place =  self.getPlaceByID(id: id)
                    self.searchResultPlaces?.append(place)
                }
                
            }
            
            return })
        
        return self.searchResultPlaces!
    }
    
    func getPlaceByID(id: String ) -> Place{
        var place = Place(id: "test", name: "testing", type: "test")
        
        self.placesClient?.fetchPlace(fromPlaceID: id, placeFields: .all, sessionToken: self.token, callback: { (res, error) in
            
            if let error = error {
                print("Autocomplete error: \(error)")
                return
            }
            
            guard let id = res?.placeID, let name = res?.name, let type = res?.types?[0]
                //   let address = placeRes?.formattedAddress
                else{
                    return
            }
            place = Place(id: id, name: name, type: type)
            
            if let address = res?.formattedAddress , let coordinate = res?.coordinate {
                
                let location = Location( id: place.placeID!, adress: address, long: coordinate.longitude, latt: coordinate.latitude)
                place.setLocation(location: location)
            }
            
            if  let phone = res?.phoneNumber , let website = res?.website?.absoluteString {
                place.setContactInfo(phone: phone, website: website)
            }
            if let images = res?.photos{
                var pics = [String]()
                for image in images{
                    pics.append("https://csb065e1ed02c47x44dcx855.blob.core.windows.net/fintunegoalcontainer/07945b9e-2696-4799-a07c-1f58bf6c5c35.jpg")
                }
                
                place.pictures = pics
            }
            
            if let operationTimes = res?.openingHours?.weekdayText {
                place.SetOperatingHours(times: operationTimes)
            }
            if let open = res?.isOpen().rawValue{
                
                print("place open Now \(open)")
                place.OpenNow(open: open)
            }
            
            if let priceRange = res?.priceLevel.rawValue{
                
                print ( " ************* price level of place \(priceRange)")
            }
            if let rating = res?.rating, let users = res?.userRatingsTotal{
                print("rating is \(rating) by \(users) user")
                place.setrating(rating: rating, totalUsers: Int(users))
            }
            
            print ("place *****")
        })
        
        return place
    }
}
