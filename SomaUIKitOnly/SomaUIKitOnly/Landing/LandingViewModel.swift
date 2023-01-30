//
//  LandingViewModel.swift
//  SomaUIKitOnly
//
//  Created by Michael Brockman on 1/29/23.
//

import UIKit

struct LandingViewModel {
  let banners = [
    makeBannerImage(from: UIImage(named: "soma_banner")!),
    makeBannerImage(from: UIImage(named: "soma_3rd_degree")!),
    makeBannerImage(from: UIImage(named: "soma_prof_garrett")!),
    makeBannerImage(from: UIImage(named: "soma_pedro_prof")!),
    makeBannerImage(from: UIImage(named: "soma_bottom_banner")!),
  ]
  
  let cards = [
    Card(image: UIImage(named: "soma_progress")!, text: "Soma Academy"),
    Card(image: UIImage(systemName: "calendar")!, text: "Schedule"),
    Card(image: UIImage(named: "youth_program")!, text: "Youth Program"),
    Card(image: UIImage(named: "adult_program")!, text: "Adult Program"),
  ]
    
}
