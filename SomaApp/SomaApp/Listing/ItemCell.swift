//
//  ItemCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import UIKit

class ItemCell: UICollectionViewCell {
  static let reuseID = String(describing: ItemCell.self)
  
  let label = UILabel()
  
  func configure() {
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    contentView.addSubview(label)
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
    ])
  }
}
