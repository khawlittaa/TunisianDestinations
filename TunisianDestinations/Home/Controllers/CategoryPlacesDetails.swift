//
//  CategoryPlacesDetails.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class CategoryPlacesDetails: UIViewController {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var categoryPlacesTable: UITableView!
    
    var categoryPlaceDetailsVM = CategoryPlaceDetailsViewModel()
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUptableView()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        categoryPlaceDetailsVM.findPlaces()
        categoryPlacesTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categoryPlacesTable.reloadData()
    }
    
    func updateUI(){
        self.categoryNameLabel.text = categoryPlaceDetailsVM.category?.placeSubCategoryName
        
        loadImg(url: (categoryPlaceDetailsVM.category?.placeSubCategoryImageURI!)!) { (img) in
            self.categoryImage.image = img
        }
        categoryPlacesTable.reloadData()
    }
    
    func bindViewModelToView() {
        
        let viewModelsValueHandler: ([Place]?) -> Void = { [weak self] _ in
            self?.categoryPlacesTable.reloadData()
        }
        
        categoryPlaceDetailsVM.$categoryPlaces
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
        
    }
    
    private func setUpBindings() {
        bindViewModelToView()
    }
    
    func SetUptableView(){
        categoryPlacesTable.dataSource = self
        categoryPlacesTable.delegate = self
        categoryPlacesTable.registerCell(nib: "GeneralInfoCell", cellreuseIdentifier: "GeneralInfoCell")
    }
    
    func  loadImg(url: String, onComplition : @escaping (UIImage) ->() )
    {
        
        let image = URL(string: url)!
        
        do{
            let data = try Data(contentsOf: image)
            
            //  display img when available
            onComplition(UIImage(data: data) ?? UIImage(named: "tunisia")!)
        }
        catch{
            print(" error loading image from url \(error)")
        }
    }
    
}
// MARK: - UITableViewDelegate
extension CategoryPlacesDetails: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeVC = getVCfromStoryboard(storyboard: "Search", VCIdentifier: "PlaceDetails") as! PlaceDetailsVC
        placeVC.place = categoryPlaceDetailsVM.categoryPlaces?[indexPath.row] as! Place
        
        self.navigationController?.pushViewController(placeVC, animated: true)
    }
}
// MARK: - UITableViewDataSource
extension CategoryPlacesDetails: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryPlaceDetailsVM.categoryPlaces?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = categoryPlacesTable.dequeueReusableCell(withIdentifier: "GeneralInfoCell") as! GeneralInfoCell
        // set values here
        cell.updateUI(place: (categoryPlaceDetailsVM.categoryPlaces?[indexPath.row])!)
        return cell
    }
    
    
}
