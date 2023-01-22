//
//  ListingCVCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

class ListingCVCell: UICollectionViewCell {
  static let reuseID = "ListingCVCell"
  
  let textStackView = UIStackView()
  let titleLabel = UILabel()
  let dateLabel = UILabel()
  
  let imageView = UIImageView()
  
  var video: Video?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
//    backgroundColor = .secondarySystemBackground
//    contentView.layer.cornerRadius = 20
//    layer.cornerRadius = 20
//    contentView.clipsToBounds = true
//    clipsToBounds = true
    layer.shadowColor = .init(gray: 1, alpha: 1)
    layer.shadowRadius = 10
    
    addSubviews(textStackView, imageView)

    textStackView.translatesAutoresizingMaskIntoConstraints = false
    textStackView.axis = .vertical
//    textStackView.addArrangedSubviews(titleLabel, dateLabel)
    textStackView.addArrangedSubviews(titleLabel) //TODO: Decide on having stack view for more info vs not
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 2
    titleLabel.font = .preferredFont(forTextStyle: .body).bold()
    titleLabel.textColor = .white
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.zPosition = -1
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    
    NSLayoutConstraint.activate([
      
      textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.inset),
      textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.inset),
      textStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -K.inset),
      
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 200),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
    ])

  }
  
  func set(with v: Video) {
    self.video = v
    guard let video = self.video else { return }
    titleLabel.text = video.title
    
    if let cachedData = CacheManager.getVideoCache(video.thumbnail) {
      let image = UIImage(data: cachedData)
      
      Task { @MainActor in
        self.imageView.image = image
      }
      return
    }
    
    guard let thumbnail = self.video?.thumbnail else { return }
    let session = URLSession.shared
    
    Task {
      guard let url = URL(string: thumbnail) else { return }
      
      let (data, response) = try await session.data(from: url)
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
      
      CacheManager.setVideoCache(url.absoluteString, data: data)
      let image = UIImage(data: data)
      
      Task { @MainActor in
        self.imageView.image = image
      }
    }
  }
  
}



