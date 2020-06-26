//
//  ProfileVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Reachability

class ProfileVC: UIViewController {
    
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var SignUpBtn: UIButton!
    private var  reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! reachability = Reachability()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setBtnAppearance()
        // adding Network reachability notifier to listen to networkStatus changees
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func setBtnAppearance(){
        LoginBtn.layer.cornerRadius = 15
        SignUpBtn.layer.cornerRadius  = 15
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
            self.presentAlert(withTitle: "No Internet Connection", message: "Make sure your device is connected to the internet.", actions: ["OK" : .default] , completionHandler: nil)
        case .none:
            print("None")
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        let login = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "Login")
        self.navigationController?.pushViewController(login, animated: true)
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        let signUp = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "SignUp")
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
}
