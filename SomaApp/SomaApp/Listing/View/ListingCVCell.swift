//
//  ListingCVCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

class ListingCVCell: UICollectionViewCell {
  static let reuseID = "ListingCVCell"
  
  let textLabel = UILabel()
  let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    addSubview(textLabel)
    
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.numberOfLines = 2

    
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: topAnchor),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])

  }
  
  func set(with video: Video) {
    textLabel.text = video.title
    
  }
  
}

//class ListingCVHeaderView: UICollectionReusableView {
//
//  let section: Section
//  @IBOutlet weak var textLabel: UILabel!
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//
//    textLabel.text = section.rawValue
//    textLabel.textAlignment = .center
//
//  }
//}



