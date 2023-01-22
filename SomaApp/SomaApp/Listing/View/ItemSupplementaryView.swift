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
    textLabel.font = UIFont.preferredFont(forTextStyle: .title2).bold()
    textLabel.textColor = .label
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.inset),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.inset),
      textLabel.topAnchor.constraint(equalTo: topAnchor, constant: K.inset),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -K.inset)
    ])
  }
}

