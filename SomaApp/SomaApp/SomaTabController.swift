//
//  SomaTabController.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/19/23.
//

import UIKit
import SwiftUI

final class SomaTabController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let landingVC = LandingViewController()
    let listingVC = ListingViewController()
    let infoVC = InfoViewController()
    
    let landingTabBarItem = UITabBarItem(title: "Welcome", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    let listingTabBarItem = UITabBarItem(title: "Videos", image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
    let infoTabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    
    landingVC.tabBarItem = landingTabBarItem
    listingVC.tabBarItem = listingTabBarItem
    infoVC.tabBarItem = infoTabBarItem
    
    viewControllers = [landingVC, listingVC, infoVC]
    #if DEBUG
    selectedIndex = 1 // TODO: Delete
    #endif
  }
}
