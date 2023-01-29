//
//  ViewFactory.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/20/23.
//

import UIKit

//func makeVC(withImage image: String) -> UIViewController {
//  let vc = UIViewController()
//  vc.view.frame = .zero
//  vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////  vc.view.backgroundColor = .systemPink
//
//  guard let uiImage = UIImage(named: image) else { fatalError("Incorrect image passed in") }
//  let imageView = makeBannerImage(from: uiImage)
//  imageView.layer.cornerRadius = 20
//  imageView.clipsToBounds = true
//  imageView.contentMode = .scaleAspectFill
//  imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//  vc.view.addSubview(imageView)
//  return vc
//}

func makeBannerImage(from image: UIImage) -> UIImage {
  guard let cgImage = image.cgImage else { fatalError("Could not make a cgImage from that UIImage.") }
  let fixedImage = UIImage(cgImage: cgImage, scale: 1000, orientation: .right)
  return fixedImage
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

extension UIViewController {
  func makeBlurView() -> UIView {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    return blurEffectView
  }
}
