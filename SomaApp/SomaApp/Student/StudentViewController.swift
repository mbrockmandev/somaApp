//
//  StudentViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//
//TODO: add info details...

import UIKit

class StudentViewController: UIViewController {
  
  let btnColor = UIColor.systemPink
  let defaults = UserDefaults.standard
  let titleLabel = UILabel()
  var isUserLoggedIn = true //TODO: Remove and replace with below
//  var isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
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
    
    let backgroundImageView = UIImageView(image: UIImage(named: "soma_red_black"))
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.layer.opacity = 0.3
    
    view.backgroundColor = .systemBackground
    loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(showAlert))
    navigationItem.rightBarButtonItem = loginButton
    
    titleLabel.font = .preferredFont(forTextStyle: .title2).bold()
    titleLabel.text = "Sign-In Here!"
    
    let buttonStackView = UIStackView()
    buttonStackView.axis = .vertical
    buttonStackView.alignment = .leading
    buttonStackView.spacing = 16
    
    button1.setTitle("Dayton PM Foundations Class", for: .normal)
    button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button1.tintColor = btnColor
    
    button2.setTitle("Dayton Advanced Class", for: .normal)
    button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button2.tintColor = btnColor
    
    button3.setTitle("Dayton Skills Class", for: .normal)
    button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button3.tintColor = btnColor
    
    button4.setTitle("Dayton AM Foundations Class", for: .normal)
    button4.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button4.tintColor = btnColor
    
    button5.setTitle("NEW WAIVER", for: .normal)
    button5.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button5.tintColor = btnColor
  
    
    buttonStackView.addArrangedSubviews(button1, button2, button3, button4, button5)
    view.addSubviews(backgroundImageView, titleLabel, buttonStackView)
    turnTamicOffFor(backgroundImageView, titleLabel, buttonStackView, button1, button2, button3, button4, button5)
    
    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.inset * 2),
      titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.inset * 2),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      
      buttonStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: K.inset * 2),
      buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.inset * 2),
      
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
    case button1: // dayton pm foundations
      launchURL(Constants.DAYTON_PM_FOUNDATIONS_ONE_TAP)
      
    case button2: // dayton advanced class
      launchURL(Constants.DAYTON_ADV_ONE_TAP)
      
    case button3: // dayton skills class
      launchURL(Constants.DAYTON_SKILLS_ONE_TAP)
      
    case button4: // dayton am foundations class
      launchURL(Constants.DAYTON_AM_FOUNDATIONS_ONE_TAP)
      
    case button5: // new waiver
      launchURL(Constants.SOMA_WAIVER_ONE_TAP)
      
    default: //should not need a default?
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

struct StudentPreviews: PreviewProvider {
  static var previews: some View {
    SomaTabControllerPreview {
      let vc = SomaTabController()
      vc.selectedIndex = 3
      return vc
    }
  }
}
#endif


