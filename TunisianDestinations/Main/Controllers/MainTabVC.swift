//
//  MainTabVC.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/25/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {
    
    @IBOutlet weak var mainTab: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC =  getVCfromStoryboard(storyboard: "Home", VCIdentifier: "HomeNavVC")
        let searchVC = getVCfromStoryboard(storyboard: "Search", VCIdentifier: "SearchNavVC")
        let eventsVC = getVCfromStoryboard(storyboard: "Events", VCIdentifier: "EventsNavVC")
        let profileVC = getVCfromStoryboard(storyboard: "Profile", VCIdentifier: "ProfileNavVC")
        let settingsVC = getVCfromStoryboard(storyboard: "Settings", VCIdentifier: "SettingsNavVC")
        
        viewControllers = [homeVC,searchVC,eventsVC,profileVC,settingsVC]
        
        setTabBar(tabBarVC: homeVC, title: "Home", imageName: "home")
        setTabBar(tabBarVC: searchVC, title: "Search", imageName: "search")
        setTabBar(tabBarVC: eventsVC, title: "Events", imageName: "event")
        setTabBar(tabBarVC: settingsVC, title: "Settings", imageName: "settings")
        setTabBar(tabBarVC: profileVC, title: "Profile", imageName: "user")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        mainTab.barTintColor = 
    }
    
    func setTabBar(tabBarVC: UIViewController , title: String, imageName: String){
        tabBarVC.tabBarItem.title = title
        let image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
        tabBarVC.tabBarItem.image = image
        
        
    }
}
