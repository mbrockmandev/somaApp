//
//  StudentViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//
//TODO: add info details...

import UIKit

class StudentViewController: UIViewController {
  
  var isUserLoggedIn = true //UserDefaults.standard.bool(forKey: "isUserLoggedIn")
  var blurView: UIVisualEffectView?
  var loginButton: UIBarButtonItem!
  let buttonLabel = UILabel()
  let button1 = UIButton(configuration: .borderedTinted())
  let button2 = UIButton(configuration: .borderedTinted())
  let button3 = UIButton(configuration: .borderedTinted())
  let button4 = UIButton(configuration: .borderedTinted())
  let button5 = UIButton(configuration: .borderedTinted())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    if !isUserLoggedIn {
      showAlert()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkLoginStatusAndUpdateUI()
  }
  
  
  func setupView() {
    let view = UIView()
    
    view.backgroundColor = .systemBackground
    loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(showAlert))
    navigationItem.rightBarButtonItem = loginButton
    
    // add label to this view? (buttonLabel)
    
    button1.setTitle("Dayton PM Foundations Class", for: .normal)
    button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    
    button2.setTitle("Dayton Advanced Class", for: .normal)
    button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    
    button3.setTitle("Dayton Skills Class", for: .normal)
    button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    
    button4.setTitle("Dayton AM Foundations Class", for: .normal)
    button4.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    
    button5.setTitle("NEW WAIVER", for: .normal)
    button5.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
  
    
    view.addSubviews(button1, button2, button3, button4, button5)
    turnTamicOffFor(button1, button2, button3, button4, button5)
    
    NSLayoutConstraint.activate([
      button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      
      button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 50),
      
      button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 50),
      
      button4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 50),
      
      button5.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button5.topAnchor.constraint(equalTo: button4.bottomAnchor, constant: 50),
      
    ])
    
    self.view = view
  }
}

extension StudentViewController {
  @objc private func showAlert() {
    let alert = UIAlertController(title: "Enter Password", message: "Please login to use full functionality of this app.", preferredStyle: .alert)
    alert.addTextField { textField in
      textField.isSecureTextEntry = true
      textField.placeholder = "Password"
    }
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      if let password = alert.textFields?.first?.text, !password.isEmpty {
        if password == Constants.SOMA_PASSWORD {
          UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
          self.isUserLoggedIn = true
          self.checkLoginStatusAndUpdateUI()
        }
      }
    }))
    
    present(alert, animated: true, completion: nil)
  }

}

//MARK: - Custom Methods
extension StudentViewController {
  func checkLoginStatusAndUpdateUI() {
    if isUserLoggedIn {
      view.isUserInteractionEnabled = true
      removeBlurEffect()
      loginButton.isEnabled = false
      loginButton.isHidden = true
    }  else {
      view.isUserInteractionEnabled = false
      addBlurEffect()
      loginButton.isEnabled = true
    }
  }
  
  func addBlurEffect() {
    let blurEffect = UIBlurEffect(style: .systemThickMaterial)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = view.bounds
    blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(blurView)
    self.blurView = blurView
  }
  
  func removeBlurEffect() {
    blurView?.removeFromSuperview()
    blurView = nil
  }

  @objc func buttonTapped(_ sender: UIButton) {
    switch sender {
    case button1:
      launchURL("https://www.onetapcheckin.com/p#/checkin?uniqueId=JB5aisH7SR700nON8e8TN")
    case button2:
      launchURL("https://www.onetapcheckin.com/p#/checkin?uniqueId=XumwCupvm5MhDYOmrN1pe")
    case button3:
      launchURL("https://www.onetapcheckin.com/p#/checkin?uniqueId=XPYc1hcOLCNwMY2Isj0gt")
    case button4:
      launchURL("https://www.onetapcheckin.com/p#/checkin?uniqueId=vXjO543hS5vlw_Dhe5MBg")
    case button5:
      launchURL("https://app.cleverwaiver.com/render/templateByRefId/63e240e2d6200e25a9d14796")
    default:
      break
    }
  }
  
  func launchURL(_ urlString: String) {
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}

  //MARK: SwiftUI Style Preview for UIKit
#if DEBUG
import SwiftUI
struct StudentViewControllerPreview<StudentViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: StudentViewController, context: Context) { }
  let viewController: StudentViewController
  init(_ builder: @escaping () -> StudentViewController) { viewController = builder() }
  func makeUIViewController(context: Context) -> StudentViewController { viewController }
}

struct InfoViewController_Previews: PreviewProvider {
  static var previews: some View {
    StudentViewControllerPreview {
      let vc = StudentViewController()
      return vc
    }
  }
}
#endif


