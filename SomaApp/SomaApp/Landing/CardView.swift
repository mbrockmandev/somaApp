//
//  AboutView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

class CardView: UIView {
  let aboutText: [String] = [
    "Who is Soma Academy?",
    "A nationwide Gracie Brazilian Jiu-Jitsu association under the guidance of 4th Degree Gracie Jiu-Jitsu Black Belt, Professor Matt Strack, who received his black belt from 8th degree Master Pedro Sauer in 2006. Professor Strack is currently a 4th degree black belt from 9th degree Grand Master Relson Gracie.",
    "What is the mission of Soma Academy?",
    "To provide quality instruction to our students in a clean, inclusive, family friendly environment, through curriculum driven, effective, real world self-defense techniques that are not based on size, strength, athletic ability, or time limits.",
    "The Vision:",
    "To unlock the full potential of our students.",
    "Why \"Soma?\"",
    "The word 'Soma' comes from from Greek sōma ‘body’ and is used in our name because Jiu-Jitsu is not only known as one of the most effective forms of martial arts, but is also one of the earliest forms of exercise or physical fitness in existence, providing for a complete workout of the body and mind.",
  ]
  
//  lazy var blurView: UIView = {
//    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
//    let blurView = UIVisualEffectView(effect: blurEffect)
//    blurView.frame = bounds
//    addSubview(blurView)
//    return blurView
//  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureView() {
    let containerView = UIView()
    let headlineLabel = makeBoldLabel(withText: aboutText[0])
    let bodyLabel = makeSubLabel(withText: aboutText[1])
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = .systemMint
    containerView.layer.cornerRadius = 20
    containerView.clipsToBounds = true
    
    addSubviews(containerView)
    containerView.addSubviews(headlineLabel, bodyLabel)
    
    NSLayoutConstraint.activate([
      
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      headlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: K.inset),
      headlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: K.inset),
      headlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -K.inset),
      
      bodyLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: K.inset),
      bodyLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      bodyLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -K.inset * 2),
      
    ])
  }
  
  override var intrinsicContentSize: CGSize {
    .init(width: frame.width - 36, height: frame.height / 3)
  }
  
}

#if DEBUG
import SwiftUI
struct ViewWrapper: UIViewRepresentable {
  func updateUIView(_ uiView: UIView, context: Context) {
    
  }
  
  func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
    return CardView()
  }
}
#endif

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    ViewWrapper()
  }
}
