//
//  MapViewController.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {
    static  var mapView:GMSMapView?
    var placesClient = GMSPlacesClient()
    private var infoWindow = MapMarkerPlaceInfoView()
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    
    let searchVM = SearchViewModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
//        MapVC.mapView?.delegate = self
        self.infoWindow = loadNiB()
        
        setPlacesAPI()
        guard let long = locationManager.location?.coordinate.latitude, let latt =  locationManager.location?.coordinate.longitude else{
            return
        }
        setMapView(lattitude: latt, longitude: long)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadNiB() -> MapMarkerPlaceInfoView {
        let infoWindow = MapMarkerPlaceInfoView.instanceFromNib() as! MapMarkerPlaceInfoView
        return infoWindow
    }
    
    static  func getVisibleRegion() -> GMSVisibleRegion?{
        guard let visibleRegion =  mapView?.projection.visibleRegion() else {
            return nil
        }
        return visibleRegion
    }
    
    func pinPlaces() {
        let marker = GMSMarker()
        
        guard let places = searchVM.searchResultPlaces else {
            return
        }
        for place in places{
//            marker.position = CLLocationCoordinate2DMake(place.placeLocation!.lattitude, place.placeLocation!.longitude)
//            //        marker.title = place.placeName
//            //        marker.snippet = location.formattedAddress
//            marker.map = MapVC.mapView
//            marker.tracksInfoWindowChanges = true
//            MapVC.mapView?.reloadInputViews()
            MapVC.pinPlace(place: place)
        }
    }
    
    // pin place on map
    static func pinPlace(place: Place) {
        let marker = GMSMarker()
        
        guard let location = place.placeLocation else {
            return
        }
        marker.position = CLLocationCoordinate2DMake(location.lattitude, location.longitude)
        marker.title = place.placeName
        marker.snippet = location.formattedAddress
        marker.map = MapVC.mapView
        marker.tracksInfoWindowChanges = true
        MapVC.mapView?.reloadInputViews()
        
    }
    
    func pinCurrentLocation(long:Double, latt: Double){
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    let addr =   place.formattedAddress?.components(separatedBy: ", ") .joined(separator: "\n")
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(long, latt)
                    marker.title = place.name
                    marker.snippet = addr
                    marker.map = MapVC.mapView
                }
            }
        })
    }
    
    func setPlacesAPI(){
        GMSServices.provideAPIKey(Constants.GooglePlacesAPIKey)
        GMSPlacesClient.provideAPIKey(Constants.GooglePlacesAPIKey)
        
        placesClient = GMSPlacesClient.shared()
        
        locationManager.requestAlwaysAuthorization()
    }
    
    func setMapView(lattitude: CLLocationDegrees ,longitude: CLLocationDegrees){
        let camera = GMSCameraPosition.init(latitude: longitude, longitude:  lattitude, zoom: 12)
        MapVC.mapView = GMSMapView.map(withFrame:CGRect.zero , camera: camera)
        view  = MapVC.mapView
//        MapVC.mapView?.delegate = self
    }
    
    
}

//MARK: - GMSMapViewDelegate

extension MapVC: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("info window tapped")
        let placeVC = getVCfromStoryboard(storyboard: "Search", VCIdentifier: "PlaceDetails") as! PlaceDetailsVC
//        placeVC.place = (searchVM.searchResultPlaces?[indexPath.row])!
        self.navigationController?.pushViewController(placeVC, animated: true)
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            guard let location = locationMarker?.position else {
                print("locationMarker is nil")
                return
            }
            infoWindow.center = mapView.projection.point(for: location)
            infoWindow.center.y = infoWindow.center.y - 110
        }
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }
}

