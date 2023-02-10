//
//  ShopViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/10/23.
//

import UIKit

class ShopViewController: UIViewController {
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension ShopViewController {
  func style() {
    view.backgroundColor = .systemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
      // Image
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(systemName: "square.and.arrow.up")
    
      // Label
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = 0
    label.text = "Text here!"
  }
  
  func layout() {
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
    ])
  }
}

