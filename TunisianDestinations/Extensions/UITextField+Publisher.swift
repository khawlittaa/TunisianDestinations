//
//  UITextField+Publisher.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/9/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//


import UIKit
import Combine

extension UITextField {
    var textChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .map { $0.text ?? "" } // mapping UITextField to extract text
            .eraseToAnyPublisher()
    }
    
    var textEndEditingPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .map { $0.text ?? "" } // mapping UITextField to extract text
            .eraseToAnyPublisher()
    }
    
    var isValid: Bool {
          get {
            return textColor == UIColor.red
          }
          set {
              textColor = newValue ? .black : .red
          }
      }
}
