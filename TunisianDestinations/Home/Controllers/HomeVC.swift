//
//  HomeVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    
    @IBOutlet weak var placeCategoriesTableView: UITableView!
    
    @IBOutlet weak var topViewLabel: UILabel!
    @IBOutlet weak var topViewImage: UIImageView!
    
    private var bindings = Set<AnyCancellable>()
    
    var homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        homeVM.onAppear()
        placeCategoriesTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func bindViewModelToView() {
        
        let viewModelsValueHandler: ([PlaceCategory]?) -> Void = { [weak self] _ in
            self?.placeCategoriesTableView.reloadData()
        }
        
        homeVM.$categories
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
    }
    
    private func setUpBindings() {
        bindViewModelToView()
    }
    
    func setUpTableView(){
        
        placeCategoriesTableView.delegate = self
        placeCategoriesTableView.dataSource = self
        
        placeCategoriesTableView.registerCell(nib: "PlaceTypeCell", cellreuseIdentifier: "PlaceTypeCell")
        placeCategoriesTableView.registerHeaderFooter(nib: "CustomCategoryNameHeader", HeaderFooterreuseIdentifier: "CustomCategoryNameHeader")
    }
}

extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeVM.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTypeCell", for: indexPath) as! PlaceTypeCell
        cell.cellDelegate = self //set the delegate to view controller
        cell.placeTypesVM.types = (homeVM.categories?[indexPath.section].subCategories) ?? []
        return cell
    }
}

extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = placeCategoriesTableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomCategoryNameHeader") as! CustomCategoryNameHeader
        headerView.setCategryName(category: homeVM.categories?[section].placeCategoryName ?? "Category name")
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
}

extension HomeVC: CustomCollectionCellDelegate {
    func collectionView(collectioncell: CategoryCell?, didTappedInTableview TableCell: PlaceTypeCell) {
        //let cell = collectioncell send info to cell here
        
        let categoryVC = UIStoryboard(name:  "Home", bundle: nil).instantiateViewController(identifier: "CategoryPlacesDetails") as! CategoryPlacesDetails
        categoryVC.categoryPlaceDetailsVM.category = collectioncell?.placeSubCategory
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
}

