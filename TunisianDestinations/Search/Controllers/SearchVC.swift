//
//  SearchVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/25/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import GooglePlaces
import Combine

class SearchVC: UIViewController {
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var placeSearchBar: UISearchBar!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var placesTable: UITableView!
    @IBOutlet weak var SearchFiltersCollectionView: UICollectionView!
    
    let searchVM = SearchViewModel()
    let searchFilterVM = SearchFiltersViewModel()
    let autocompleteController = GMSAutocompleteViewController()
    let mapVC = MapVC()
    var coordonate:CLLocationCoordinate2D?
    var resultsViewController: GMSAutocompleteResultsViewController?
    var tableDataSource: GMSAutocompleteTableDataSource?
    var filterChoice: String = ""
    
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpSearchBars()
        setUpTableView()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placesTable.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setUpTableView(){
        placesTable.registerCell(nib: "GeneralInfoCell", cellreuseIdentifier: "GeneralInfoCell")
        
        hideLocationSearchBar()
        setUpViewByViewType()
        
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource?.delegate = self
    }
    
    func SetUpSearchBars(){
        //        searchDisplayController = UISearchController(nibName: locationSearchBar, bundle: self)
        searchDisplayController?.searchResultsDataSource = tableDataSource
        searchDisplayController?.searchResultsDelegate = tableDataSource
        searchDisplayController?.delegate = self
        SearchFiltersCollectionView.dataSource = searchFilterVM
        SearchFiltersCollectionView.delegate = self
        
        placeSearchBar.delegate = self
        locationSearchBar.delegate = self
        autocompleteController.delegate = self
        
        resultsViewController = GMSAutocompleteResultsViewController()
        
        locationSearchBar.setImage(UIImage(systemName: "map"), for: .search, state: .normal)
    }
    
    func showLocationSearchBar(){
        let searchbarHeight: CGFloat = 56
        locationSearchBar.constraints.last?.constant = searchbarHeight
    }
    
    func bindViewModelToView() {
        
        let viewModelsValueHandler: ([Place]?) -> Void = { [weak self] _ in
            self?.placesTable.reloadData()
        }
        
        searchVM.$searchResultPlaces
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
        
    }
    
    func bindViewToViewModel() {
        locationSearchBar.searchTextField.textEndEditingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchLocation, on: searchVM)
            .store(in: &bindings)
        
        placeSearchBar.searchTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchString, on: searchVM)
            .store(in: &bindings)
        
    }
    
    private func setUpBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    func hideLocationSearchBar(){
        let searchbarHeight: CGFloat = 0
        let constraints = [
            locationSearchBar.heightAnchor.constraint(equalToConstant: searchbarHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setUpViewByViewType(){
        if searchVM.viewType == .list{
            placeSearchBar.setImage(UIImage(systemName: "map"), for: .bookmark, state: .normal)
            mapContainerView.isHidden = true
            placesTable.isHidden = false
            reloadInputViews()
        }else {
            placeSearchBar.setImage(UIImage(systemName: "list.bullet"), for: .bookmark, state: .normal)
            placesTable.isHidden = true
            mapContainerView.isHidden = false
            //  mapVC.searchVM.searchResultPlaces = self.searchVM.searchResultPlaces
            //   mapVC.pinPlaces()
            pinLocationsOnMap()
        }
    }
    
    func pinLocationsOnMap(){
        if let places =  searchVM.searchResultPlaces{
            for place in places{
                MapVC.pinPlace(place: place)
            }
        }
    }
    
    func showAutocompeteController(){
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.countries = ["TN"]
        filter.type = .region
        autocompleteController.autocompleteFilter = filter
        
        autocompleteController.primaryTextHighlightColor = .black
        autocompleteController.primaryTextColor = .systemGray
        autocompleteController.secondaryTextColor = .lightGray
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func showFilterChoicespopUp(choices: [PlaceSubCategory], filterName: String){
        let popup = getVCfromStoryboard(storyboard: "Search", VCIdentifier: "SearchFilterChoicesPopUP") as! SearchFilterChoicesPopUP
        popup.filterName = filterName
        popup.placeFilterChoices = choices
        /// popup.vM
        popup.searchVM = searchVM
        popup.eventsVM = nil
        popup.tabBar = tabBarController as? MainTabVC
        tabBarController?.present(popup, animated: true, completion: nil)
    }
    
}

//MARK: - UISearchDisplayDelegate & GMSAutocompleteTableDataSourceDelegate
extension SearchVC: UISearchDisplayDelegate, GMSAutocompleteTableDataSourceDelegate{
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // TODO: Handle the error.
        print("Error: \(error)")
    }
    
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        searchDisplayController?.isActive = false
        // Do something with the selected place
        print("Place name: \(place.name)")
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        tableDataSource?.sourceTextHasChanged(searchString)
        return false
    }
    
    func tableDataSource(tableDataSource: GMSAutocompleteTableDataSource, didSelectPrediction prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
}

//MARK: - GMSAutocompleteViewControllerDelegate
extension SearchVC: GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        coordonate = place.coordinate
        
        locationSearchBar.text = place.name
        // search places in selected location
        // print("Place name: \(place.name)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //    // Turn the network activity indicator on and off again.
    //    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //    }
    //
    //    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //    }
}

//MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let place = placeSearchBar?.text
        let location = locationSearchBar?.text
        
        if  place?.isEmpty == false{
            //pop up type something
            if !location!.isEmpty{
                // location & place
                searchVM.searchPlaceByAddress(name: place!, address: location!, coord: self.coordonate!)
                placeSearchBar.text = "\(place!)  \(location!) "
            }else{
                // place & current location
                searchVM.searchPlacesByName(name: place!)
            }
        }else{
            if location?.isEmpty == false{
                // !place & location
            } else {
                // ! place & !current Location
            }
        }
        placesTable.reloadData()
        searchBar.endEditing(true)
        hideLocationSearchBar()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showLocationSearchBar()
        placeSearchBar.text = ""
        if searchBar == locationSearchBar {
            showAutocompeteController()
        }else{
            // reset search text evry time
            searchBar.text = ""
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        /// chane viewType and update icone
        searchVM.changeViewType()
        setUpViewByViewType()
    }
}
extension SearchVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchFilterVM.items[indexPath.row]
        switch item.type{
        case .distance:
            print("filter by distance")
            searchVM.searchResultPlaces =  searchFilterVM.filterByDistance(distanceFromMe: 3000,  places:searchVM.searchResultPlaces)!
        case .openNow:
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            let currentHour = formatter.string(from: currentDate)
            print("places that are open Now!\(currentHour)")
            searchVM.searchResultPlaces =  searchFilterVM.openNowFilter(places: searchVM.searchResultPlaces)!
        case .category:
            //MARK:- filter by category! 
            print("filter by category!")
            showFilterChoicespopUp(choices: item.filterChoices, filterName: item.FilterTitle)
        default:
            print("error !")
        }
        placesTable.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension SearchVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = placesTable.dequeueReusableCell(withIdentifier: "GeneralInfoCell") as! GeneralInfoCell
        // set values here
        cell.updateUI(place: (searchVM.searchResultPlaces?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.searchResultPlaces!.count
    }
}

//MARK: - UITableViewDelegate
extension SearchVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeVC = getVCfromStoryboard(storyboard: "Search", VCIdentifier: "PlaceDetails") as! PlaceDetailsVC
        placeVC.place = (searchVM.searchResultPlaces?[indexPath.row])!
        self.navigationController?.pushViewController(placeVC, animated: true)
    }
}
