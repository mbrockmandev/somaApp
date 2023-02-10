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
    let messageVC = MessageViewController()
    let shopVC = ShopViewController()
    
    let landingTabBarItem = UITabBarItem(title: "Welcome", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    let listingTabBarItem = UITabBarItem(title: "Videos", image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
    let messageTabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
    let shopTabBarItem = UITabBarItem(title: "Shop", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
   
    
    landingVC.tabBarItem = landingTabBarItem
    listingVC.tabBarItem = listingTabBarItem
    messageVC.tabBarItem = messageTabBarItem
    shopVC.tabBarItem = shopTabBarItem
    
    let controllers = [landingVC, listingVC, messageVC, shopVC]
    viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    
    #if DEBUG
    selectedIndex = 0 // TODO: Delete
    #endif
  }
}

  //MARK: SwiftUI Style Preview for UIKit
#if DEBUG
import SwiftUI
struct SomaTabControllerPreview<SomaTabController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: SomaTabController, context: Context) { }
  let viewController: SomaTabController
  init(_ builder: @escaping () -> SomaTabController) { viewController = builder() }
  func makeUIViewController(context: Context) -> SomaTabController { viewController }
}

struct SomaTabController_Previews: PreviewProvider {
  static var previews: some View {
    SomaTabControllerPreview {
      let vc = SomaTabController()
      return vc
    }
  }
}
#endif

