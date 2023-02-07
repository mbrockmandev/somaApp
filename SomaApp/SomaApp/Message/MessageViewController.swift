//
//  MessageViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/7/23.
//

import UIKit

class MessageViewController: UIViewController {
  
  let subtitleLabel = UILabel()
  let textField = UITextField(frame: .init(x: 0, y: 0, width: 390, height: 500))
  let submitButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension MessageViewController {
  func style() {
    view.backgroundColor = .systemBackground
    
    subtitleLabel.numberOfLines = 0
    subtitleLabel.textAlignment = .left
    subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
    subtitleLabel.adjustsFontSizeToFitWidth = true
    subtitleLabel.text = "Please submit any Jiu-Jitsu related questions you have and an instructor will respond within 2-3 business days."
    
    textField.delegate = self
    textField.contentVerticalAlignment = .top
    textField.placeholder = "Enter your question here…"
    textField.autocorrectionType = .default
    textField.autocapitalizationType = .sentences
    textField.backgroundColor = .secondarySystemBackground
    
    submitButton.setTitle("Send Message".uppercased(), for: .normal)
    submitButton.setTitleColor(.tintColor, for: .normal)
    submitButton.configuration = .borderedTinted()
    submitButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    
  }
  
  func layout() {
    turnTamicOffFor(subtitleLabel, textField, submitButton)
    view.addSubviews(subtitleLabel, textField, submitButton)
    
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset * 4),
      subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset * 2),
      subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset * 2),
      
      textField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: K.inset * 3),
      textField.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
      textField.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
      textField.heightAnchor.constraint(equalToConstant: 400),
      
      submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: K.inset * 3),
      submitButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
      submitButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
      submitButton.heightAnchor.constraint(equalToConstant: 60),
      
    ])
  }
  
  @objc private func btnTapped(_ sender: UIButton) {
    print("Button tapped!")
    
    // implement email functionality? should auto generate an email to soma jj email presumably
  }
}

extension MessageViewController: UITextFieldDelegate {
  
}

#if DEBUG
import SwiftUI
struct MessageViewControllerPreview<MessageViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: MessageViewController, context: Context) {
    
  }
  
  let viewController: MessageViewController
  
  init(_ builder: @escaping () -> MessageViewController) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> MessageViewController {
    viewController
  }
}
#endif

struct MessageViewController_Previews: PreviewProvider {
  static var previews: some View {
    MessageViewControllerPreview {
      let vc = MessageViewController()
      return vc
    }
  }
}
