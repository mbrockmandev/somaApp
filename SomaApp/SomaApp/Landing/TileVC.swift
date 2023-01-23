//
//  TileVC.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

final class TileVC: UIViewController {
  
  let label = UILabel()
  let button = UIButton(configuration: .borderedTinted())
  let imageView: UIImageView? = nil
  var index: Int!
  
  let aboutText: [String] = [
    "A nationwide Gracie Brazilian Jiu-Jitsu association under the guidance of 4th Degree Gracie Jiu-Jitsu Black Belt, Professor Matt Strack, who received his black belt from 8th degree Master Pedro Sauer in 2006. Professor Strack is currently a 4th degree black belt from 9th degree Grand Master Relson Gracie.",
    "To provide quality instruction to our students in a clean, inclusive, family friendly environment, through curriculum driven, effective, real world self-defense techniques that are not based on size, strength, athletic ability, or time limits.",
    "To unlock the full potential of our students.",
    "The word 'Soma' comes from from Greek sōma ‘body’ and is used in our name because Jiu-Jitsu is not only known as one of the most effective forms of martial arts, but is also one of the earliest forms of exercise or physical fitness in existence, providing for a complete workout of the body and mind.",
  ]
  
  init(_ text: String) {
    super.init(nibName: nil, bundle: nil)
    label.text = text
  }
  
  init(_ text: String, image: UIImage) {
    super.init(nibName: nil, bundle: nil)
    label.text = text
    imageView?.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .secondarySystemBackground
    layout()
    setupTap()
  }
}

extension TileVC {
  
  private func layout() {
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    view.layer.shadowRadius = 10
    view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      view.heightAnchor.constraint(equalToConstant: 160),
    ])
  }
  
  private func setupTap() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tileTapped))
    view.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc func tileTapped(_ gestureRecognizer: UITapGestureRecognizer) {
    
    let cardView = CardView(text: aboutText[index], headline: label.text)
    present(cardView, animated: true)

  }
}
