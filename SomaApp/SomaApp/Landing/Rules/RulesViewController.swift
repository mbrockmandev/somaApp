//
//  RulesViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/7/23.
//

//TODO: add rules from the website

import UIKit

class RulesViewController: UIViewController {
  
  let stackView = UIStackView()
  
  let titleLabel = UILabel()
  let imageView = UIImageView()
  let subtitleLabel = UILabel()
  let bodyLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension RulesViewController {
  func style() {
    view.backgroundColor = .systemBackground

    // container
    stackView.axis = .vertical
    stackView.spacing = K.inset
    stackView.distribution = .equalCentering
    
    // soma
    titleLabel.text = "Soma Academy"
    titleLabel.textAlignment = .center
    titleLabel.font = .preferredFont(forTextStyle: .largeTitle).bold()
    
    // logo
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "soma_crest")
    
    // rules subtitle
    subtitleLabel.text = "Rules of Etiquette"
    subtitleLabel.textAlignment = .center
    subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title1).bold()
    
    // body text
    bodyLabel.textAlignment = .center
    bodyLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    bodyLabel.adjustsFontForContentSizeCategory = true
    bodyLabel.numberOfLines = 0
    bodyLabel.text = "Text here!"
  }
  
  func layout() {
    turnTamicOffFor(titleLabel, stackView, imageView, bodyLabel)
    stackView.addArrangedSubviews(titleLabel, imageView, subtitleLabel, bodyLabel)
    stackView.setCustomSpacing(30, after: subtitleLabel)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -K.inset),
    ])
  }
}

#if DEBUG
import SwiftUI
struct RulesViewControllerPreview<RulesViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: RulesViewController, context: Context) {
    
  }
  
  let viewController: RulesViewController
  
  init(_ builder: @escaping () -> RulesViewController) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> RulesViewController {
    viewController
  }
}
#endif

struct RulesViewControllerPreviews_Previews: PreviewProvider {
  static var previews: some View {
    RulesViewControllerPreview {
      let vc = RulesViewController()
      return vc
    }
  }
}
