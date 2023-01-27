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
    let messageVC = UIHostingController(rootView: MessageView())
//    let infoVC = UIHostingController(rootView: InfoView())
    let infoVC = UIHostingController(rootView: InfoViewProto())
    
    
    let landingTabBarItem = UITabBarItem(title: "Welcome", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    let listingTabBarItem = UITabBarItem(title: "Videos", image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
    let messageTabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
    let infoTabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    
    landingVC.tabBarItem = landingTabBarItem
    listingVC.tabBarItem = listingTabBarItem
    messageVC.tabBarItem = messageTabBarItem
    infoVC.tabBarItem = infoTabBarItem
    
    let controllers = [landingVC, listingVC, messageVC, infoVC]
    viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    
    #if DEBUG
    selectedIndex = 2 // TODO: Delete
    #endif
  }
}
