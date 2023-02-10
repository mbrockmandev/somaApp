//
//  InstructorCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/10/23.
//

import UIKit

class InstructorCell: UICollectionViewCell {
  
  let backgroundHeight: CGFloat = 280
  let foregroundHeight: CGFloat = 240
  let cardWidth:        CGFloat = 380
  
  let cardBackgroundView  = UIView()
  let cardForegroundView  = UIView()
  let profileImageView    = UIImageView()
  let profileNameLabel    = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
  }
  
  func set(with profile: Profile) {
    print(#function)
    profileImageView.image = UIImage(named: profile.image)
    profileNameLabel.text  = profile.name
  }
  
  required init?(coder: NSCoder) { fatalError("NO STORYBOARD") }
  
  private func configureView() {

    
    cardBackgroundView.frame              = CGRect(x: 0, y: 0, width: cardWidth, height: backgroundHeight)
    cardBackgroundView.backgroundColor    = .systemGray.withAlphaComponent(0.6)
    cardBackgroundView.clipsToBounds      = true
    cardBackgroundView.layer.cornerRadius = 20
    cardBackgroundView.layer.borderWidth  = 2
    cardBackgroundView.layer.borderColor  = .init(gray: 0.3, alpha: 0.5)
    
    cardForegroundView.frame              = CGRect(x: 0, y: 0, width: cardWidth, height: foregroundHeight)
    cardForegroundView.backgroundColor    = .clear
    cardForegroundView.clipsToBounds      = true
    cardForegroundView.layer.cornerRadius = 20
    
    profileImageView.contentMode        = .scaleAspectFill
    profileImageView.clipsToBounds      = true
    profileImageView.layer.cornerRadius = 20
    cardForegroundView.addSubview(profileImageView)
    
    profileNameLabel.font               = .preferredFont(forTextStyle: .body).bold()
    profileNameLabel.numberOfLines      = 1
    profileNameLabel.textAlignment      = .center
    profileNameLabel.textColor          = .secondaryLabel
    profileNameLabel.shadowColor        = .label
    profileNameLabel.layer.shadowRadius = 5
    
    let blurEffect      = UIBlurEffect(style: .regular)
    let vibrancyEffect  = UIVibrancyEffect(blurEffect: blurEffect)
    let blurView        = UIVisualEffectView(effect: blurEffect)
    let vibrancyView    = UIVisualEffectView(effect: vibrancyEffect)
    blurView.frame      = cardBackgroundView.bounds
    vibrancyView.frame  = cardBackgroundView.bounds
    cardBackgroundView.addSubview(blurView)
    blurView.contentView.addSubview(vibrancyView)
    
    addSubviews(cardBackgroundView, cardForegroundView, profileImageView, profileNameLabel)
    turnTamicOffFor(cardBackgroundView, cardForegroundView, profileImageView, profileNameLabel)
    
    NSLayoutConstraint.activate([
      cardBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: K.inset*10),
      cardBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.inset*2),
      cardBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.inset*2),
      cardBackgroundView.heightAnchor.constraint(equalToConstant: backgroundHeight),
      
      cardForegroundView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: K.inset*2),
      cardForegroundView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: K.inset*4),
      cardForegroundView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -K.inset*4),
      cardForegroundView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: -K.inset*8),
      
      profileImageView.topAnchor.constraint(equalTo: cardForegroundView.topAnchor),
      profileImageView.leadingAnchor.constraint(equalTo: cardForegroundView.leadingAnchor),
      profileImageView.trailingAnchor.constraint(equalTo: cardForegroundView.trailingAnchor),
      profileImageView.bottomAnchor.constraint(equalTo: cardForegroundView.bottomAnchor),
      
      profileNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: K.inset*2),
      profileNameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor, constant: K.inset),
    ])
  }
  
}
