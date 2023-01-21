//
//  ItemCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import UIKit

final class ItemCell: UICollectionViewCell {
  static let reuseID = String(describing: ItemCell.self)
  
  let label = UILabel()
  let thumbnailImageView = UIImageView()
  
  func configure() {
    
    backgroundColor = .systemPink
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    contentView.addSubview(label)
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    
    thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(thumbnailImageView)
    thumbnailImageView.image = UIImage(systemName: "star")
    
    
    let padding: CGFloat = 8
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
      
      thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
    ])
  }
  
  func set(with item: Item) {
    label.text = item.title
//    thumbnailImageView.image = UIImage(named: item.url)
    
  }
}
