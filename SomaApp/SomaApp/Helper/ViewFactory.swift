//
//  ViewFactory.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/20/23.
//

import UIKit

func makeVC(withImage image: String) -> UIViewController {
  let vc = UIViewController()
  vc.view.frame = .zero
  
  guard let uiImage = UIImage(named: image) else { fatalError("Incorrect image passed in") }
  let imageView = makeBannerImage(from: uiImage)
  imageView.translatesAutoresizingMaskIntoConstraints = false
  imageView.layer.cornerRadius = 20
  imageView.clipsToBounds = true
  imageView.contentMode = .scaleAspectFill
  
  vc.view.addSubview(imageView)
  
  vc.pinToEdges(imageView)
  vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  
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
