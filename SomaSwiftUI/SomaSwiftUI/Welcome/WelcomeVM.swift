//
//  WelcomeVM.swift
//  SomaSwiftUI
//
//  Created by Michael Brockman on 1/28/23.
//

import SwiftUI

struct WelcomeViewModel {
  let images = [
    makeBannerImage(from: UIImage(named: "soma_banner")!),
    makeBannerImage(from: UIImage(named: "soma_3rd_degree")!),
    makeBannerImage(from: UIImage(named: "soma_bottom_banner")!),
    makeBannerImage(from: UIImage(named: "soma_giesler")!),
    makeBannerImage(from: UIImage(named: "soma_pedro_prof")!),
    makeBannerImage(from: UIImage(named: "soma_prof_garrett")!),
  ]
  
  let cornerRadius: CGFloat = 20
}

func makeBannerImage(from image: UIImage) -> UIImage {
  guard let cgImage = image.cgImage else { fatalError("Could not make a cgImage from that UIImage.") }
  let fixedImage = UIImage(cgImage: cgImage, scale: 1000, orientation: .right)
  return fixedImage
}

