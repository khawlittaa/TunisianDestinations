//
//  UIButton+Validation.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/9/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

extension UIButton {
    var isValid: Bool {
        get {
            return isEnabled && backgroundColor == UIColor(named: "lightIndigo")
        }
        set {
            backgroundColor = newValue ? UIColor(named: "lightIndigo") : .lightGray
            isEnabled = newValue
        }
    }
}
