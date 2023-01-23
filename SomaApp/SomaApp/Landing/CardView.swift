//
//  AboutView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

class CardView: UIView {
  var text: String
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
    
  init(text: String) {
    self.text = text
    super.init(frame: .zero)
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureView() {
    backgroundColor = .systemGray4
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(named: "soma_crest"))
    let stackView = UIStackView(frame: .zero)
    let headlineLabel = makeBoldLabel(withText: aboutText[0])
    let bodyLabel = makeSubLabel(withText: aboutText[1])
        
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
    stackView.spacing = 16
    
    addSubviews(imageView, containerView)
    containerView.addSubviews(stackView)
    stackView.addArrangedSubviews(headlineLabel, bodyLabel)
    
    NSLayoutConstraint.activate([
      
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.inset),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.inset),
      containerView.heightAnchor.constraint(equalToConstant: 200),

      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),

      stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: K.inset),
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: K.inset),
      stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -K.inset),
      
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
    return CardView(text: "A nationwide Gracie Brazilian Jiu-Jitsu association under the guidance of 4th Degree Gracie Jiu-Jitsu Black Belt, Professor Matt Strack, who received his black belt from 8th degree Master Pedro Sauer in 2006. Professor Strack is currently a 4th degree black belt from 9th degree Grand Master Relson Gracie.")
  }
}
#endif

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    ViewWrapper()
  }
}
