//
//  ItemSupplementaryView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import UIKit

final class ItemSupplementaryView: UICollectionReusableView {
  static let reuseID = String(describing: ItemSupplementaryView.self)
  
  let textLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) is not implemented")
  }
  
  private func configure() {
    addSubview(textLabel)
    textLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      textLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
    ])
  }
}

