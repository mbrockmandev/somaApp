//
//  CardElement.swift
//  SomaUIKitOnly
//
//  Created by Michael Brockman on 1/30/23.
//

import UIKit

class CardElement: LandingModel {
  var text: String
  
  var type: LandingCellType { return .card }
  
  init(text: String = "") {
    self.text = text
  }
}

class CardElementCell: UITableViewCell, LandingCell {
  var model: CardElement!
  
  func configure(with elementModel: LandingModel) {
    guard let model = elementModel as? CardElement else {
      print("unable to cast as CardElement: \(String(describing: model))")
      return
    }
    self.model = model
    
    configureUI()
  }
  
  func configureUI() {
    let label = makeLabel(withText: model.text)
    addSubview(label)
    label.numberOfLines = 0
    label.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview().inset(16)
    }
  }
}
