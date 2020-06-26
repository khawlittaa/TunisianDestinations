//
//  SearchFilterChoicesDatesPopUP.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/17/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Combine

class SearchFilterChoicesDatesPopUP: UIViewController {
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var startDateText: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    
    @IBOutlet weak var errorMsgLbl: UILabel!
    
    private var bindings = Set<AnyCancellable>()
    
    var tapGesture = UITapGestureRecognizer()
    
    var startdate = Date()
    var filterName: String = "filter"
    var eventVM = SearchEventViewModel()
    var eventFilterVM = EventFiltersViewModel()
    
    var tabBar: MainTabVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        setUpTargets()
        SetUpAppances()
        setUpBindings()
    }
    
    private func SetUpAppances(){
        popUpView.layer.cornerRadius = 20
        popUpView.layer.masksToBounds = true
        filterBtn.layer.cornerRadius = 15
    }
    
    private func setUpTargets() {
        startDateText.setInputViewDatePickerforEvent(target: self, selector: #selector(tapStartDone))
        endDateTxt.setInputViewDatePickerforEvent(target: self, selector: #selector(tapEndDone))
    }
    
    private func addGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBaseTapOnly))
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func setMinDate(){
        
        if let datePicker = self.endDateTxt.inputView as? UIDatePicker {
            let minDate = self.startDateText.text!.StringToDate()
            datePicker.minimumDate = minDate
        }
    }
    
    func bindViewToViewModel() {
        startDateText.textEndEditingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.startDateFilter, on: eventVM)
            .store(in: &bindings)
        
        endDateTxt.textEndEditingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.endDateFilter, on: eventVM)
            .store(in: &bindings)
    }
    
    func bindViewModelToView() {
        eventVM.validatedDates
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: filterBtn)
            .store(in: &bindings)
        
        eventVM.validatedDates
            .receive(on: RunLoop.main)
            .assign(to: \.isHidden, on: errorMsgLbl)
            .store(in: &bindings)
    }
    
    private func setUpBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @objc func tapStartDone() {
        if let datePicker = self.startDateText.inputView as? UIDatePicker {
            setMinDate()
            self.startDateText.text = datePicker.date.DateToString()
        }
        self.startDateText.resignFirstResponder()
    }
    
    @objc func tapEndDone(){
        
        if let datePicker = self.endDateTxt.inputView as? UIDatePicker {
            
            let minDate = self.startDateText.text!.StringToDate()
            datePicker.minimumDate = minDate
            
            self.endDateTxt.text = datePicker.date.DateToString()
        }
        self.endDateTxt.resignFirstResponder()
    }
    
    
    @IBAction func filterBtnPressed(_ sender: Any) {
        //filtr by dates and update places in eventVM based on res from eventFilterVM
        eventFilterVM.items[1].isSelected = true
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension SearchFilterChoicesDatesPopUP: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    @objc func onBaseTapOnly(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
