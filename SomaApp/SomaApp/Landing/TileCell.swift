//
//  TileCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/30/23.
//

import UIKit

class TileCell: UICollectionViewCell {
  
  let tileLabel = UILabel()
  let underlineView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) { fatalError("no storyboards!") }
  
  func set(with text: String) {
    tileLabel.text = text
  }
  
  private func configureUI() {
    tileLabel.translatesAutoresizingMaskIntoConstraints = false
    underlineView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubviews(tileLabel, underlineView)
    
    backgroundColor = .systemBackground.withAlphaComponent(0.6)
    layer.cornerRadius = 20
    tileLabel.font = .preferredFont(forTextStyle: .headline).bold()

    
    underlineView.backgroundColor = .systemMint
    
    NSLayoutConstraint.activate([
      tileLabel.topAnchor.constraint(equalTo: topAnchor, constant: K.inset * 3),
      tileLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.inset * 2),
      tileLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.inset),
      tileLabel.heightAnchor.constraint(equalToConstant: 20),
      
      underlineView.topAnchor.constraint(equalTo: tileLabel.bottomAnchor, constant: 2),
      underlineView.leadingAnchor.constraint(equalTo: tileLabel.leadingAnchor),
      underlineView.trailingAnchor.constraint(equalTo: tileLabel.trailingAnchor),
      underlineView.heightAnchor.constraint(equalToConstant: 2),
    ])
  }
  
}

