//
//  LandingHeaderView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

final class LandingHeaderView: UIView {
  
  let titleGreeting = UILabel()
  let iconButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension LandingHeaderView {
  private func style() {
    backgroundColor = .systemBackground
    
    titleGreeting.translatesAutoresizingMaskIntoConstraints = false
    titleGreeting.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    titleGreeting.text = "Soma Academy"
    titleGreeting.numberOfLines = 0
    titleGreeting.lineBreakMode = .byWordWrapping
    
    setupIconButton()
  }
  
  private func layout() {

    addSubviews(titleGreeting, iconButton)
    
    
    NSLayoutConstraint.activate([
      
      titleGreeting.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      titleGreeting.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: titleGreeting.trailingAnchor, multiplier: 1),
      
      iconButton.topAnchor.constraint(equalToSystemSpacingBelow: titleGreeting.bottomAnchor, multiplier: 2),
      iconButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      bottomAnchor.constraint(equalToSystemSpacingBelow: iconButton.bottomAnchor, multiplier: 1),
      iconButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
      
    ])
  }
  
  override var intrinsicContentSize: CGSize {
    CGSize(width: 100, height: 100)
  }
  
  private func setupIconButton() {
    iconButton.translatesAutoresizingMaskIntoConstraints = false
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: "sun.fill", withConfiguration: configuration)
    
    iconButton.setImage(image, for: .normal)
//    iconButton.imageView?.tintColor = .secondaryLabel
    iconButton.imageView?.contentMode = .scaleAspectFit
    
    iconButton.setTitle("Menu", for: .normal)
    iconButton.setTitleColor(.secondaryLabel, for: .normal)
    
  }
}


#if DEBUG
import SwiftUI
struct LandingHeaderView_Wrapper: UIViewRepresentable {
  
  func updateUIView(_ uiView: UIView, context: Context) {
    
  }
  
  func makeUIView(context: UIViewRepresentableContext<LandingHeaderView_Wrapper>) -> UIView {
    return LandingHeaderView()
  }
}
#endif

struct LandingHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    LandingHeaderView_Wrapper()
  }
}

