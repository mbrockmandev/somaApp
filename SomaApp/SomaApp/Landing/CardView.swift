//
//  AboutView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

class CardView: UIViewController {
  var text: String
  var headline: String!
    
  init(text: String, headline: String?) {
    self.text = text
    self.headline = headline
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    view.backgroundColor = .systemGray4
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(named: "soma_crest"))
    let stackView = UIStackView(frame: .zero)
    let headlineLabel = makeBoldLabel(withText: headline)
    let bodyLabel = makeSubLabel(withText: text)
        
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 20
    containerView.clipsToBounds = true
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
  
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = imageView.bounds
    imageView.addSubview(blurView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 8
    stackView.distribution = .fillProportionally
    
    view.addSubviews(imageView, containerView)
    containerView.addSubviews(stackView)
    stackView.addArrangedSubviews(headlineLabel, bodyLabel)
    
    NSLayoutConstraint.activate([
      
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset),
      containerView.heightAnchor.constraint(equalToConstant: 240),

      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: K.inset * 2),
      stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: K.inset),
      stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -K.inset),
      
    ])
  }
  
}
