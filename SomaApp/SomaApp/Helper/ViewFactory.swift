//
//  ViewFactory.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/20/23.
//

import UIKit

func makeVC(withImage image: String) -> UIViewController {
  let vc = UIViewController()
  vc.view.translatesAutoresizingMaskIntoConstraints = false
  
  guard let uiImage = UIImage(named: image) else { fatalError("Incorrect image passed in") }
  let imageView = makeBannerImage(from: uiImage)
  imageView.translatesAutoresizingMaskIntoConstraints = false
  imageView.clipsToBounds = true
  
  vc.view.addSubview(imageView)
  
  NSLayoutConstraint.activate([
    imageView.topAnchor.constraint(equalTo: vc.view.topAnchor),
    imageView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
    imageView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
    imageView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
  ])
  
  return vc
}

func makeBannerImage(from image: UIImage) -> UIImageView {
  guard let cgImage = image.cgImage else { fatalError("Could not make a cgImage from that UIImage.") }
  let fixedImage = UIImage(cgImage: cgImage, scale: 6, orientation: .right)
  return UIImageView(image: fixedImage)
}

func makeLabel(withText text: String) -> UILabel {
  let label = UILabel()
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = text
  label.textColor = .label
  label.font = UIFont.preferredFont(forTextStyle: .body)
  
  return label
}

func makeSubLabel(withText text: String) -> UILabel {
  let label = UILabel()
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = text
  label.textColor = .label
  label.font = UIFont.preferredFont(forTextStyle: .subheadline)
  label.numberOfLines = 0 // multiline
  label.lineBreakMode = .byWordWrapping
  
  return label
}

func makeBoldLabel(withText text: String) -> UILabel {
  let label = UILabel()
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = text
  label.textColor = .label
  label.font = UIFont.boldSystemFont(ofSize: 18)
  label.shadowColor = .systemGray2
  label.lineBreakMode = .byWordWrapping
  
  return label
}
