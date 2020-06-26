//
//  EventsVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class EventsVC: UIViewController {
    
    @IBOutlet weak var eventsSearchBar: UISearchBar!
    @IBOutlet weak var eventFiltersCollectionView: UICollectionView!
    @IBOutlet weak var eventsListTable: UITableView!
    
    let eventFitersVM = EventFiltersViewModel()
    let eventsVM = SearchEventViewModel()
    
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpTableView()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventsVM.onAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setUpTableView(){
        eventsListTable.dataSource = self
        eventsListTable.delegate = self
        
        eventsListTable.registerCell(nib: "EventInfoCell", cellreuseIdentifier: "EventInfoCell")
    }
    
    func setUpCollectionView(){
        eventFiltersCollectionView.dataSource = eventFitersVM
        eventFiltersCollectionView.delegate = self
    }
    
    
    func bindViewToViewModel() {
        
        eventsSearchBar.searchTextField.textChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchKeyword, on: eventsVM)
            .store(in: &bindings)
        
    }
    
    func bindViewModelToView() {
        
        let viewModelsValueHandler: ([Event]?) -> Void = { [weak self] _ in
            self?.eventsListTable.reloadData()
        }
        
        eventsVM.$events
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
        
        let FilterviewModelValueHandler: ([EventFilterTypeViewModelItem]?) -> Void = { [weak self] _ in
            self?.eventFiltersCollectionView.reloadData()
        }
        
        eventFitersVM.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: FilterviewModelValueHandler)
            .store(in: &bindings)
        
    }
    
    private func setUpBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    func showFilterChoicespopUp(choices: [EventCategory]?, filterName: String){
        if filterName == "Category"{
            let   popUp = getVCfromStoryboard(storyboard: "Search", VCIdentifier: "SearchFilterChoicesPopUP") as! SearchFilterChoicesPopUP
            popUp.filterName = filterName
            popUp.eventFilterChoices = choices!
            // setting upp vMs in pop Up
            popUp.eventsVM = self.eventsVM
            popUp.searchVM = nil
            popUp.eventFilterVM = self.eventFitersVM
            popUp.tabBar = tabBarController as? MainTabVC
            tabBarController?.present(popUp, animated: true, completion: nil)
        }else{
            let    popUp = getVCfromStoryboard(storyboard: "Events", VCIdentifier: "SearchFilterChoicesDatesPopUP") as! SearchFilterChoicesDatesPopUP
            popUp.filterName = filterName
            // setting upp VMs in pop Up
            popUp.eventVM = self.eventsVM
            popUp.eventFilterVM = self.eventFitersVM
            
            popUp.tabBar = tabBarController as? MainTabVC
            tabBarController?.present(popUp, animated: true, completion: nil)
        }
    }
    
}

extension EventsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsVM.events.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = eventsListTable.dequeueReusableCell(withIdentifier: "EventInfoCell") as! EventInfoCell
        // set values here
        return cell
    }
}

extension EventsVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeVC = getVCfromStoryboard(storyboard: "Events", VCIdentifier: "EventDetailsVC") as! EventDetailsVC
        //  placeVC.place = (searchVM.searchResultPlaces?[indexPath.row])!
        self.navigationController?.pushViewController(placeVC, animated: true)
    }
    
}
extension EventsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = eventFitersVM.items[indexPath.row]
        switch item.type{
        case .Category:
            //MARK:- filter by category!
            print("filter by category!")
            showFilterChoicespopUp(choices: item.filterChoices, filterName: item.FilterTitle)
        case .Periode:
            print("filter by Date!")
            showFilterChoicespopUp(choices: nil, filterName: item.FilterTitle)
        }
    }
}
