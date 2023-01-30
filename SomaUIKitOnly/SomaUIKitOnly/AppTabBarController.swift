  //
  //  AppTabBarController.swift
  //  SomaUIKitOnly
  //
  //  Created by Michael Brockman on 1/29/23.
  //

import UIKit

class AppTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let landingVC = LandingViewController()
    let videoVC = VideoViewController()
    let messageVC = MessageViewController()
    let infoVC = InfoViewController()
    
    let landingTabBarItem = UITabBarItem(title: "Welcome", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    let listingTabBarItem = UITabBarItem(title: "Videos", image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
    let messageTabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
    let infoTabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    
    
    landingVC.tabBarItem = landingTabBarItem
    videoVC.tabBarItem = listingTabBarItem
    messageVC.tabBarItem = messageTabBarItem
    infoVC.tabBarItem = infoTabBarItem
    
    let controllers = [landingVC, videoVC, messageVC, infoVC]
    viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    
#if DEBUG
    selectedIndex = 0 
#endif
    
  }
}
