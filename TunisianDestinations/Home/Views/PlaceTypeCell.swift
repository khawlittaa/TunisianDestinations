//
//  PlaceTypeCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/23/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class PlaceTypeCell: UITableViewCell {
    
    @IBOutlet weak var placeTypeCollectionView: UICollectionView!
    
    weak var cellDelegate: CustomCollectionCellDelegate? //define delegate
    let placeTypesVM = PlaceTypesViewModel()
    
    private var bindings = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindViewModelToView()
        SetUpTableview()
    }
    
    func SetUpTableview(){
        placeTypeCollectionView.delegate = self
        placeTypeCollectionView.dataSource = placeTypesVM
        
        placeTypeCollectionView.registerCell(nib: "CategoryCell", cellreuseIdentifier: "CategoryCell")
    }
    
    func bindViewModelToView() {
        let viewModelsValueHandler: ([PlaceSubCategory]?) -> Void = { [weak self] _ in
            self?.placeTypeCollectionView.reloadData()
        }
        
        placeTypesVM.$types
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelsValueHandler)
            .store(in: &bindings)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension PlaceTypeCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        cell?.placeSubCategory =  placeTypesVM.types[indexPath.row]
        self.cellDelegate?.collectionView(collectioncell: cell, didTappedInTableview: self)
        
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension PlaceTypeCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 120, height: collectionView.frame.height)
        return size
    }
}
