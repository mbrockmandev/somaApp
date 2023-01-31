//
//  ListingCVCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

class ListingCVCell: UICollectionViewCell {
  
  let titleLabel = UILabel()
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
    layer.shadowColor = .init(gray: 1, alpha: 1)
    layer.shadowRadius = 10
    
    addSubviews(titleLabel, imageView)
//    backgroundColor = .systemPink
//    layer.borderColor = .init(red: 0, green: 1, blue: 0, alpha: 1)
//    layer.borderWidth = 2
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    imageView.layer.zPosition = -1
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 2
    titleLabel.font = .preferredFont(forTextStyle: .body)
    titleLabel.textColor = .white
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.9
    titleLabel.shadowColor = .systemGray5
    titleLabel.layer.shadowRadius = 5
    titleLabel.lineBreakMode = .byWordWrapping
    
    NSLayoutConstraint.activate([
      
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageView.heightAnchor.constraint(equalTo: heightAnchor),
//      imageView.topAnchor.constraint(equalTo: topAnchor, constant: K.inset * 1.5),
//      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -K.inset * 1.5),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.2),
      
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//      titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -K.inset),
      titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: K.inset),
      titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: K.inset),
      titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -K.inset),
//      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.inset),
//      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.inset),
      
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



