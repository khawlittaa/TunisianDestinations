//
//  searchFilterChoicesPopUP.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/30/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class SearchFilterChoicesPopUP: UIViewController {
    
    @IBOutlet weak var filterNameLbl: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var filterChoicesTableView: UITableView!
    
    var tapGesture = UITapGestureRecognizer()
    
    var eventFilterChoices: [EventCategory] = []
    var placeFilterChoices: [PlaceSubCategory] = []
    var filterName: String = "filter"
    var searchVM: SearchViewModel?
    var eventsVM: SearchEventViewModel?
    var searchFilterVM = SearchFiltersViewModel()
    var eventFilterVM = EventFiltersViewModel()
    
    var tabBar: MainTabVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAppearnces()
        setUPTableView()
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterChoicesTableView.reloadData()
    }
    
    func setUpAppearnces(){
        
        popUpView.layer.cornerRadius = 20
        popUpView.layer.masksToBounds = true
        
        filterNameLbl.text = filterName
    }
    
    func setUPTableView(){
        self.filterChoicesTableView.delegate = self
        self.filterChoicesTableView.dataSource = self
        self.filterChoicesTableView.reloadData()
    }
    
    private func addGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBaseTapOnly))
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
    }
}

extension SearchFilterChoicesPopUP: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    @objc func onBaseTapOnly(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UITableViewDataSource
extension SearchFilterChoicesPopUP: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let search = searchVM{
            return placeFilterChoices.count
        }else{
            if let event = eventsVM{
                return eventFilterChoices.count
            }
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = filterChoicesTableView.dequeueReusableCell(withIdentifier: "FilterChoiceCell") as! FilterChoiceCell
        if let search = searchVM{
            cell.filterChoiceLbl.text = placeFilterChoices[indexPath.row].placeSubCategoryName
        }else{
            if let event = eventsVM{
                cell.filterChoiceLbl.text = eventFilterChoices[indexPath.row].eventCategoryName
            }
            
        }
        
        return cell
    }
}
// MARK: - UITableViewDelegate
extension SearchFilterChoicesPopUP: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get selceted category here
        // filter places by category
        if let search = searchVM {
            let filterChoice = placeFilterChoices[indexPath.row]
            search.searchResultPlaces =   searchFilterVM.filterbyCategory(categoryName: filterChoice.placeSubCategoryName!, places: searchVM?.searchResultPlaces)
        }else {
            if let event = eventsVM{
                let filterChoice = eventFilterChoices[indexPath.row]
                event.events = eventFilterVM.filterbyCategory(categoryName: filterChoice.eventCategoryName!, events: event.events)!
                eventFilterVM.items[0].isSelected = true
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
