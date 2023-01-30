//
//  LandingElement.swift
//  SomaUIKitOnly
//
//  Created by Michael Brockman on 1/30/23.
//

import UIKit

class BannerElement: LandingModel {
  var image: UIImage?
  
  var type: LandingCellType { return .banner }
  
  init(image: UIImage? = nil) {
    self.image = image
  }
}

class BannerElementCell: UITableViewCell, LandingCell {
  var model: BannerElement!
  
  func configure(with elementModel: LandingModel) {
    guard let model = elementModel as? BannerElement else {
      print("unable to cast as BannerElement: \(String(describing: model))")
      return
    }
    self.model = model
    
    configureUI()
  }
  
  func configureUI() {
    let banner = UIImageView()
    banner.image = model.image
    addSubview(banner)
    banner.contentMode = .scaleAspectFill
    banner.clipsToBounds = true
    
    banner.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(240)
    }
  }
}
