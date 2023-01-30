//
//  LandingCardCell.swift
//  SomaUIKitOnly
//
//  Created by Michael Brockman on 1/30/23.
//

import UIKit

class LandingCardCell: UITableViewCell {
  var iconImage = UIImageView()
  let cardText = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with card: Card) {
    self.iconImage.image = card.image
    self.cardText.text = card.text
  }
  
  private func configureUI() {
    contentView.addSubviews(iconImage, cardText)
    
    iconImage.snp.makeConstraints { make in
      make.top.trailing.equalToSuperview().inset(16)
      make.width.height.equalTo(60)
    }
    
    cardText.numberOfLines = 0
    cardText.font = .preferredFont(forTextStyle: .body)
    
    cardText.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(8)
      make.trailing.equalTo(iconImage.snp.leading).inset(8)
    }
  }
}
