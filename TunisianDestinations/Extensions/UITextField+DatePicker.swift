//
//  datePickerforTextfield.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/8/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date 
        // maximum date is current date
        
        let calendar = Calendar(identifier: .gregorian)

         let currentDate = Date()
         var components = DateComponents()
         components.calendar = calendar

         components.year = -0
         let maxDate = calendar.date(byAdding: components, to: currentDate)!

         components.year = -150
         let minDate = calendar.date(byAdding: components, to: currentDate)!

         datePicker.minimumDate = minDate
         datePicker.maximumDate = maxDate
        
        self.inputView = datePicker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    func setInputViewDatePickerforEvent(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date
        // maximum date is current date
        
        let calendar = Calendar(identifier: .gregorian)

         let currentDate = Date()
         var components = DateComponents()
         components.calendar = calendar

         components.year = -0
         let minDate = calendar.date(byAdding: components, to: currentDate)!

         datePicker.minimumDate = minDate
        
        self.inputView = datePicker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
}
