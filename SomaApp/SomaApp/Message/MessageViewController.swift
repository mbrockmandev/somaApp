//
//  MessageViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/7/23.
//

import UIKit
import MessageUI

class MessageViewController: UIViewController {
  
  let subtitleLabel = UILabel()
  let textView = UITextView(frame: .init(x: 0, y: 0, width: 390, height: 500))
  let placeholderText = "Enter your message here…"
  var userInput = ""
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
    
    textView.delegate = self
    textView.text = placeholderText
    textView.textColor = .secondaryLabel
    textView.autocorrectionType = .default
    textView.autocapitalizationType = .sentences
    textView.backgroundColor = .secondarySystemBackground
    
    submitButton.setTitle("Send Message".uppercased(), for: .normal)
    submitButton.setTitleColor(.tintColor, for: .normal)
    submitButton.configuration = .borderedTinted()
    submitButton.addTarget(self, action: #selector(sendBtnTapped), for: .touchUpInside)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    view.addGestureRecognizer(tapGesture)
  }
  
  func layout() {
    turnTamicOffFor(subtitleLabel, textView, submitButton)
    view.addSubviews(subtitleLabel, textView, submitButton)
    
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset * 4),
      subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.inset * 2),
      subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.inset * 2),
      
      textView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: K.inset * 3),
      textView.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
      textView.heightAnchor.constraint(equalToConstant: 400),
      
      submitButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: K.inset * 3),
      submitButton.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
      submitButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
      submitButton.heightAnchor.constraint(equalToConstant: 60),
      
    ])
  }
  
  // actions
  
  @objc private func sendBtnTapped(_ sender: UIButton) {
    
    if !textView.text.isEmpty {
      userInput = textView.text
    }
    
    if MFMailComposeViewController.canSendMail() {
      let mailComposeViewController = MFMailComposeViewController()
      mailComposeViewController.mailComposeDelegate = self
      mailComposeViewController.setToRecipients(["mbrockmandev@gmail.com"])
      mailComposeViewController.setSubject("Jiu-Jitsu Question From Soma App")
      mailComposeViewController.setMessageBody(userInput, isHTML: false)
        
      present(mailComposeViewController, animated: true, completion: nil)
    } else {
      showSendMailErrorAlert()
    }
}
  
  @objc private func viewTapped() {
    textView.resignFirstResponder()
  }
  
}

extension MessageViewController: MFMailComposeViewControllerDelegate {
  func showSendMailErrorAlert() {
    let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send the e-mail. Please double check your e-mail configuration and try again.", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    present(alertController, animated: true, completion: nil)
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
}

extension MessageViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .secondaryLabel {
      textView.text = nil
      textView.textColor = .label
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = placeholderText
      textView.textColor = .secondaryLabel
    }
  }

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
