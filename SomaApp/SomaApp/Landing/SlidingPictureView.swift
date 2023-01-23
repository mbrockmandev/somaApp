//
//  SlidingPictureView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

class SlidingPictureView: UIViewController {
  
  let button = UIButton(configuration: .borderedTinted())
  let imageView: UIImageView
    
  init(image: String) {
    guard let uiImage = UIImage(named: image) else { fatalError("bad image sent") }
    imageView = makeBannerImage(from: uiImage)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGroupedBackground
    configure()
  }
}

extension SlidingPictureView {
  
  private func configure() {
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    view.layer.shadowRadius = 10
    view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    
    turnTamicOffFor(button, imageView)
    view.addSubviews(button, imageView)
        
    NSLayoutConstraint.activate([
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: K.inset),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -K.inset),
      
    ])
  }
}
