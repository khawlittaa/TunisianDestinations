//
//  UIViewController+Alert.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertWithCancelAction(withTitle title: String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: { action in
            self.navigationController?.popViewController(animated: false)
            print("Remove")
        }))
        alert.addAction(UIAlertAction(title: "Finish Writing", style: UIAlertAction.Style.default, handler: { action in
            //                  self.navigationController?.popViewController(animated: false)
            print("Remove")
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func presentAlert(withTitle title: String, message : String, actions : [String: UIAlertAction.Style], completionHandler: ((UIAlertAction) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            
            let action = UIAlertAction(title: action.key, style: action.value) { action in
                
                if completionHandler != nil {
                    completionHandler!(action)
                }
            }
            
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteInfoAlert(withTitle title: String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { action in
            //                  self.navigationController?.popViewController(animated: false)
            print("Remove")
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in
            self.navigationController?.popViewController(animated: false)
            // api call here
            print("Remove")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
